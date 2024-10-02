import 'package:zabi/data/api/api_client.dart';
import 'package:zabi/data/model/response/translator_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabi/util/app_constants.dart';

class QuranSettingsController extends GetxController implements GetxService {
  final ApiClient apiClient;
  QuranSettingsController({required this.apiClient});
  @override
  void onInit() {
    super.onInit();
    getSuraTranslationApiData();
    loadSavedApiTranslateDropdownValue();
    getArabicFontSizeFromLocalStorage();
    getTranslateFontSizeFromLocalStorage();
    loadArabicFontPreference();
  }

//==============================//
//   Arabic Font size part      //
//=============================//

  RxDouble arabicFontSize = 22.0.obs; // Default font size
  final String arabicFontSizeKey = "arabic_font_size_key";

  void changeArabicFontSize(double newSize) {
    arabicFontSize.value = newSize;
    saveArabicFontSizeToLocalStorage(newSize);
  }

  void saveArabicFontSizeToLocalStorage(double size) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(arabicFontSizeKey, size);
  }

  void getArabicFontSizeFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? storedFontSize = prefs.getDouble(arabicFontSizeKey);
    if (storedFontSize != null) {
      arabicFontSize.value = storedFontSize;
    }
  }

//==============================//
//   Translate Font size part   //
//=============================//

  RxDouble translateFontSize = 14.0.obs; // Default font size
  final String translateFontSizeKey = "tanslate_font_size_key";

  void changeTranslateFontSize(double newSize) {
    translateFontSize.value = newSize;
    saveTranslateFontSizeToLocalStorage(newSize);
  }

  void saveTranslateFontSizeToLocalStorage(double size) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(translateFontSizeKey, size);
  }

  void getTranslateFontSizeFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? storedFontSize = prefs.getDouble(translateFontSizeKey);
    if (storedFontSize != null) {
      translateFontSize.value = storedFontSize;
    }
  }

//=================================//
//    Change Arabic font part     //
//===============================//

  // Define an observable variable to store the selected font
  RxBool isSelectedFontLoading = false.obs;
  RxString selectedFont = "Scheherazade New".obs; // Default font
  static const String selectedFontKey = 'selectedFont';

  void changeArabicFont(String font) {
    isSelectedFontLoading(true);
    selectedFont.value = font;
    saveArabicFontPreference(font);
    Future.delayed(const Duration(seconds: 2), () {
      isSelectedFontLoading(false);
    });
    update();
  }

  Future<void> saveArabicFontPreference(String font) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(selectedFontKey, font);
    update();
  }

  Future<void> loadArabicFontPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? font = prefs.getString(selectedFontKey);
    if (font != null) {
      selectedFont.value = font;
    }
    update();
  }

//=================================//
//    Translate Dropdown part     //
//===============================//

  RxBool isTranslateLoading = false.obs;
  RxBool isTranslateDropdownLoading = false.obs;

  List<Map<String, dynamic>> allTranslationNameList = [];
  var translateDropdown = ''.obs;
  var selectedTranslatorId = ''.obs;
  TranslatorModel? translatorApiData;

  Future<void> getSuraTranslationApiData() async {
    try {
      isTranslateLoading(true);
      update();
      // final response = await http
      //     .get(Uri.parse("https://zabi-dev.theme29.com/api/translators"));

      final response = await apiClient.getData(AppConstants.TRANSLATOR);

      if (response.statusCode == 200) {
        translatorApiData = TranslatorModel.fromJson(response.body);

        var translationlength = translatorApiData!.data!;

        for (var i = 0; i < translationlength.length; i++) {
          Map<String, dynamic> translationData = {
            'id': translationlength[i].id,
            'full_name': translationlength[i].fullName,
            'short_name': translationlength[i].shortName,
            'language': translationlength[i].language,
            'lang_code': translationlength[i].languageCode,
          };

          allTranslationNameList.add(translationData);

          translateDropdown.value = translateDropdown.value == ''
              ? "${allTranslationNameList[0]["id"]}. ${allTranslationNameList[0]["full_name"]}"
              : translateDropdown.value;
        }
      }
    } catch (e) {
      rethrow;
    } finally {
      isTranslateLoading(false);
      update();
    }
  }

  void loadSavedApiTranslateDropdownValue() async {
    final prefs = await SharedPreferences.getInstance();
    translateDropdown.value =
        prefs.getString('apiTranslateDropdown') ?? translateDropdown.value;
    selectedTranslatorId.value =
        prefs.getString('selectedTranslatorId') ?? selectedTranslatorId.value;

    update();
    if (kDebugMode) {
      print("apiTranslateDropdown===========> ${translateDropdown.value}");
      print("selectedTranslatorId===========> ${selectedTranslatorId.value}");
    }
  }

  void saveTranslateDropdownValue(newValue, selectedId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('apiTranslateDropdown', newValue);
    await prefs.setString('selectedTranslatorId', selectedId);
    update();
  }

  void updateTranslateDropdownValue(newValue, selectedId) {
    isTranslateDropdownLoading(true);
    translateDropdown.value = newValue;
    selectedTranslatorId.value = selectedId;
    saveTranslateDropdownValue(newValue, selectedId);
    Future.delayed(const Duration(seconds: 6), () {
      isTranslateDropdownLoading(false);
    });
    update();
  }

//
}
