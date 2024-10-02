import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:zabi/view/base/custom_app_bar.dart';
import 'package:zabi/view/base/loading_indicator.dart';
import 'package:zabi/view/screens/compass/widget/qiblah_compass.dart';

class CompassScreen extends StatefulWidget {
  final bool appBackButton;
  const CompassScreen({super.key, required this.appBackButton});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar start ===>
      appBar: CustomAppBar(
        title: 'qibla_compass'.tr,
        isBackButtonExist: widget.appBackButton == true ? true : false,
      ),

      // body start--->
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          // Loading section---->
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          // Error message show here--.
          if (snapshot.hasError) {
            return Center(
              child: Text("error: ${snapshot.error.toString()}".tr),
            );
          }

          if (snapshot.data!) {
            // QiblahCompass page return here-->
            return const QiblahCompass();
          }
          // error message---.
          return Center(
              child: Text('our_compass_not_support_in_your_device'.tr));
        },
      ),
    );
  }
}
