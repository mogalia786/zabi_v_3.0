// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:zabi/controller/bookmark_controller.dart';
import 'package:zabi/controller/category_controller.dart';
import 'package:zabi/controller/dikir_details_controller.dart';
import 'package:zabi/controller/dikir_list_controller.dart';
import 'package:zabi/controller/dua_list_controller.dart';
import 'package:zabi/controller/dua_details_controller.dart';
import 'package:zabi/controller/hadith_controller.dart';
import 'package:zabi/controller/haram_food_controller.dart';
import 'package:zabi/controller/juz_list_controller.dart';
import 'package:zabi/controller/local_dhikr_controller.dart';
import 'package:zabi/controller/local_dua_controller.dart';
import 'package:zabi/controller/localization_controller.dart';
import 'package:zabi/controller/mosque_settings_controller.dart';
import 'package:zabi/controller/nearby_mosque_controller.dart';
import 'package:zabi/controller/noti_sound_controller.dart';
import 'package:zabi/controller/package_prayer_time_controller.dart';
import 'package:zabi/controller/todays_prayer_time_controller.dart';
import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:zabi/controller/sifat_name_details_controller.dart';
import 'package:zabi/controller/sifat_name_list_controller.dart';
import 'package:zabi/controller/sura_detaile_controller.dart';
import 'package:zabi/controller/sura_list_controller.dart';
import 'package:zabi/controller/splash_controller.dart';
import 'package:zabi/controller/theme_controller.dart';
import 'package:zabi/controller/zakat_calculator_controller.dart';
import 'package:zabi/data/api/api_client.dart';
import 'package:zabi/data/model/response/language_model.dart';
import 'package:zabi/data/repository/splash_repo.dart';
import 'package:zabi/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../controller/donation_controller.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(
      () => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));

  //new controller
  Get.lazyPut(
      () => LocalizationController(
          sharedPreferences: Get.find(), apiClient: Get.find()),
      fenix: true);

  Get.lazyPut(() => LocalDhikrController());
  Get.lazyPut(() => LocalDuaController());
  Get.lazyPut(() => DuaListController(apiClient: Get.find()));
  Get.lazyPut(() => DonationController(apiClient: Get.find()));
  Get.lazyPut(() => DuaDetailsController(apiClient: Get.find()));
  Get.lazyPut(() => DikirListController(apiClient: Get.find()));
  Get.lazyPut(() => DikirDetailsController(apiClient: Get.find()));
  Get.lazyPut(() => SifatNameListController(apiClient: Get.find()));
  Get.lazyPut(() => SifatNameDetailsController(apiClient: Get.find()));
  Get.lazyPut(() => PackagePrayerTimeController());
  Get.lazyPut(() => TodaysPrayerTimeController(apiClient: Get.find()));
  Get.lazyPut(() => MosqueSettingsController(apiClient: Get.find()));
  Get.lazyPut(() => HaramFoodListController(apiClient: Get.find()));
  Get.lazyPut(() => NotiSoundController());

  // old controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => HadithController());
  Get.lazyPut(() => NearbyMosqueController());
  Get.lazyPut(() => QuranSettingsController(apiClient: Get.find()));
  Get.lazyPut(() => BookMarkController());
  Get.lazyPut(() => CategoryListController());
  Get.lazyPut(() => ZakatCalculatorController());
  Get.lazyPut(() => JuzListController(apiClient: Get.find()));
  Get.lazyPut(() => SuraListController(apiClient: Get.find()));
  Get.lazyPut(() => SuraDetaileController(apiClient: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = {};
    mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return languages;
}
