// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/util/styles.dart';
import 'package:zabi/view/base/loading_indicator.dart';
import 'package:zabi/view/base/location_error_widget.dart';

class QiblahCompass extends StatefulWidget {
  const QiblahCompass({super.key});

  @override
  _QiblahCompassState createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  Stream<LocationStatus> get stream => _locationStreamController.stream;

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  @override
  void dispose() {
    _locationStreamController.close();
    FlutterQiblah().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          if (snapshot.data!.enabled == true) {
            switch (snapshot.data!.status) {
              case LocationPermission.always:
              case LocationPermission.whileInUse:
                return const QiblahCompassWidget();

              case LocationPermission.denied:
                return LocationErrorWidget(
                  error:
                      "location_service_permission_denied_for_getting_this_service_please_enable_location"
                          .tr,
                );
              case LocationPermission.deniedForever:
                return LocationErrorWidget(
                  error:
                      "location_service_denied_forever_for_getting_this_service_please_enable_location"
                          .tr,
                );

              default:
                return const SizedBox();
            }
          } else {
            return LocationErrorWidget(
              error: "please_enable_location_service".tr,
            );
          }
        },
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }
}

class QiblahCompassWidget extends StatelessWidget {
  const QiblahCompassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        }

        final qiblahDirection = snapshot.data!;

        return SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 500),
                      turns: (qiblahDirection.direction * (pi / 180) * -1) /
                          (2 * pi),
                      child: Image.asset(
                        Images.Compass,
                        height: 330,
                        fit: BoxFit.fill,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 1000),
                      turns:
                          (qiblahDirection.qiblah * (pi / 180) * -1) / (2 * pi),
                      child: Image.asset(
                        Images.Compass_Needle,
                        height: 400,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 10.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).hintColor.withOpacity(0.05),
                      Theme.of(context).hintColor.withOpacity(0.10),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "${((qiblahDirection.direction - 285) % 360).toInt()}°", // 标准化方向
                      style: robotoMedium.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text('device_angle_to_qibla'.tr,
                        style: robotoMedium.copyWith(
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 40.0),
            ],
          ),
        );
      },
    );
  }
}
