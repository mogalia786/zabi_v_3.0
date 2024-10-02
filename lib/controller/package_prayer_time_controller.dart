// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prayers_times/prayers_times.dart' as pt;
import 'package:shared_preferences/shared_preferences.dart';

class PackagePrayerTimeController extends GetxController {
  RxBool isLoading = false.obs;

// Get Address Variable =====>
  var location = '';
  double? latitude;
  double? longitude;
  RxString currentAddress = '--'.obs;

// Prayer Time variable ======>
  RxString fajrStartTime = "--".obs;
  RxString fajrEndTime = "--".obs;
  RxString sunriseTime = "--".obs;
  RxString dhuhrStartTime = "--".obs;
  RxString dhuhrEndTime = "--".obs;
  RxString asrStartTime = "--".obs;
  RxString asrEndTime = "--".obs;
  RxString maghribStartTime = "--".obs;
  RxString maghribEndTime = "--".obs;
  RxString ishaStartTime = "--".obs;
  RxString ishaEndTime = "--".obs;
  RxString sehriEndTime = "--".obs;
  RxString waqtTime = "--".obs;
  RxString waqtName = "--".obs;
  var packageTimeRemaining = '00:00:00'.obs;
  var isFajrTime = true.obs;

  late Timer _timer;

  RxBool isLocationDenied = false.obs;

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Future<void> getLocation() async {
    bool serviceEnabled = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If not enabled, prompt user to enable location services
      await Geolocator.openLocationSettings();
      return;
    }

    // Check location permission status
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // If permission is denied, request permission from the user
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //   If permission is still denied, show a message to the user using GetX's Snackbar
        Get.snackbar(
          'location_permission_denied'.tr,
          "for_getting_Automatic_Prayer_Time_Nearby_Mosque_Qibla_Compass_need_to_enable_location_permission"
              .tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
          colorText: Colors.white,
          backgroundColor: Colors.red.withOpacity(0.7),
          dismissDirection: DismissDirection.horizontal,
        );

        await prefs.setBool("isLocationDenied", true);
        bool? storedFontSize = prefs.getBool("isLocationDenied");
        if (storedFontSize != null) {
          isLocationDenied.value = storedFontSize;
        }

        return;
      }
    } else if (permission == LocationPermission.deniedForever) {
      // If permission is permanently denied, show a message to the user using GetX's Snackbar

      Get.snackbar(
        'location_Permission_Denied_Forever'.tr,
        "for_getting_Automatic_Prayer_Time_Nearby_Mosque_Qibla_Compass_need_to_enable_location_permission"
            .tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
        colorText: Colors.white,
        backgroundColor: Colors.red.withOpacity(0.9),
        dismissDirection: DismissDirection.horizontal,
        mainButton: TextButton(
          onPressed: () {
            openAppSettings();
          },
          child: const Icon(
            Icons.add_location_outlined,
            size: 24,
            color: Colors.white,
          ),
        ),
      );

      await prefs.setBool("isLocationDenied", true);
      bool? storedFontSize = prefs.getBool("isLocationDenied");
      if (storedFontSize != null) {
        isLocationDenied.value = storedFontSize;
      }
      return;
    }

    // If permission is granted, retrieve the current position
    if (serviceEnabled) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
        prayerTimeAPI(position.latitude, position.longitude, currentTimeZone);
        getAddress(position.latitude, position.longitude);
        update();
      } catch (e) {
        await prefs.setBool("isLocationDenied", true);
        bool? storedFontSize = prefs.getBool("isLocationDenied");
        if (storedFontSize != null) {
          isLocationDenied.value = storedFontSize;
        }

        Get.snackbar(
          'location_Permission_Denied_Forever'.tr,
          "for_getting_Automatic_Prayer_Time_Nearby_Mosque_Qibla_Compass_need_to_enable_location_permission"
              .tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
          colorText: Colors.white,
          backgroundColor: Colors.red.withOpacity(0.9),
          dismissDirection: DismissDirection.horizontal,
          mainButton: TextButton(
            onPressed: () {
              openAppSettings();
            },
            child: const Icon(
              Icons.add_location_outlined,
              size: 24,
              color: Colors.white,
            ),
          ),
        );
      }
    }
  }

  prayerTimeAPI(double lat, double long, String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLocationDenied", false);
    bool? storedFontSize = prefs.getBool("isLocationDenied");
    if (storedFontSize != null) {
      isLocationDenied.value = storedFontSize;
    }
    pt.Coordinates coordinates = pt.Coordinates(lat, long);

    // Specify the calculation parameters for prayer times
    pt.PrayerCalculationParameters params =
        pt.PrayerCalculationMethod.karachi();
    params.madhab = pt.PrayerMadhab.hanafi;

// Create a PrayerTimes instance for the specified location
    pt.PrayerTimes prayerTimes = pt.PrayerTimes(
      coordinates: coordinates,
      calculationParameters: params,
      precision: true,
      locationName: location,
    );
    fajrStartTime.value = DateFormat.Hm().format(prayerTimes.fajrStartTime!);
    fajrEndTime.value = DateFormat.Hm().format(prayerTimes.fajrEndTime!);
    sunriseTime.value = DateFormat.Hm().format(prayerTimes.sunrise!);
    dhuhrStartTime.value = DateFormat.Hm().format(prayerTimes.dhuhrStartTime!);
    dhuhrEndTime.value = DateFormat.Hm().format(prayerTimes.dhuhrEndTime!);
    asrStartTime.value = DateFormat.Hm().format(prayerTimes.asrStartTime!);
    asrEndTime.value = DateFormat.Hm().format(prayerTimes.asrEndTime!);
    maghribStartTime.value =
        DateFormat.Hm().format(prayerTimes.maghribStartTime!);
    maghribEndTime.value = DateFormat.Hm().format(prayerTimes.maghribEndTime!);
    ishaStartTime.value = DateFormat.Hm().format(prayerTimes.ishaStartTime!);
    ishaEndTime.value = DateFormat.Hm().format(prayerTimes.ishaEndTime!);
    sehriEndTime.value = DateFormat.Hm().format(prayerTimes.sehri!);

    prayerNameAndTimes();
    updateRemainingTime();
    _timer = Timer.periodic(
        const Duration(seconds: 1), (_) => updateRemainingTime());
    update();
  }

// Get Address Function====>
  getAddress(double lat, double long) async {
    try {
      List<Placemark> addressList = await placemarkFromCoordinates(lat, long);

      final callAddress = addressList.first;
      currentAddress.value = callAddress.subAdministrativeArea!;
      update();
    } catch (e) {
      print("Location not found");
    }
  }

// Get Prayer Owakt Function=====>
  prayerNameAndTimes() {
// Get Cuttent Time Variable =====>
    String currentTime = DateFormat.Hms().format(DateTime.now());
    var finalCurrentTime = DateTime.parse('2000-01-01 $currentTime');
    if (finalCurrentTime
        .isBefore(DateTime.parse('2000-01-01 $fajrStartTime:00'))) {
      waqtName.value = "fajr".tr;
      waqtTime.value = fajrStartTime.toString();
    } else if (finalCurrentTime
        .isBefore(DateTime.parse('2000-01-01 $sunriseTime:00'))) {
      waqtName.value = "sunrise".tr;
      waqtTime.value = sunriseTime.toString();
    } else if (finalCurrentTime
        .isBefore(DateTime.parse('2000-01-01 $dhuhrStartTime:00'))) {
      waqtName.value = "dhuhr".tr;
      waqtTime.value = dhuhrStartTime.toString();
    } else if (finalCurrentTime
        .isBefore(DateTime.parse('2000-01-01 $asrStartTime:00'))) {
      waqtName.value = "asr".tr;
      waqtTime.value = asrStartTime.toString();
    } else if (finalCurrentTime
        .isBefore(DateTime.parse('2000-01-01 $maghribStartTime:00'))) {
      waqtName.value = "magrib".tr;
      waqtTime.value = maghribStartTime.toString();
    } else if (finalCurrentTime
        .isBefore(DateTime.parse('2000-01-01 $ishaStartTime:00'))) {
      waqtName.value = "isha".tr;
      waqtTime.value = ishaStartTime.toString();
    } else if (finalCurrentTime
        .isAfter(DateTime.parse('2000-01-01 $fajrStartTime:00'))) {
      waqtName.value = "fajr".tr;
      waqtTime.value = fajrStartTime.toString();
    }
  }

// count down section ====>
  void updateRemainingTime() {
    Duration packageRemainingDuration;
    DateTime now = DateTime.now();

    DateTime sehri;
    DateTime iftar;

    try {
      List<String> sehriEndParts = sehriEndTime.value.split(':');
      List<String> iftarStartParts = maghribStartTime.value.split(':');

      sehri = DateTime(now.year, now.month, now.day,
          int.parse(sehriEndParts[0]), int.parse(sehriEndParts[1]));
      iftar = DateTime(now.year, now.month, now.day,
          int.parse(iftarStartParts[0]), int.parse(iftarStartParts[1]));
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing time: $e');
      }
      return;
    }

    if (now.isBefore(sehri)) {
      packageRemainingDuration = sehri.difference(now);
      isFajrTime.value = true;
    } else if (now.isBefore(iftar)) {
      packageRemainingDuration = iftar.difference(now);
      isFajrTime.value = false;
    } else {
      // Iftar time is over, count down to Fajr time of the next day
      DateTime nextFajr = sehri.add(const Duration(days: 1));
      packageRemainingDuration = nextFajr.difference(now);
      isFajrTime.value = true;
    }

    String hours = packageRemainingDuration.inHours
        .remainder(24)
        .toString()
        .padLeft(2, '0');
    String minutes = packageRemainingDuration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String seconds = packageRemainingDuration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    packageTimeRemaining.value = '$hours:$minutes:$seconds';
  }
}
