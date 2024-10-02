import 'package:zabi/data/api/api_client.dart';
import 'package:zabi/data/model/response/sura_detile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:zabi/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuraDetaileController extends GetxController implements GetxService {
  final ApiClient apiClient;
  SuraDetaileController({required this.apiClient});
  // local variable
  RxBool isSuraDetaileLoading = false.obs;
  String? suraNumber;

  SuraDetaileModel? suraDetaileApiData;

// get sura detail function
  Future<void> fetchSuraDetaileData(
      {String? suraId, String? translatorId}) async {
    try {
      isSuraDetaileLoading(true);
      final prefs = await SharedPreferences.getInstance();
      var selectedTranslatorId =
          translatorId ?? prefs.getString('selectedTranslatorId') ?? 1;

      final response = await apiClient.getData(AppConstants.SURA_Detaile +
          suraId.toString() +
          AppConstants.TRANSLATOR_ID +
          selectedTranslatorId.toString());

      if (response.statusCode == 200) {
        suraDetaileApiData = SuraDetaileModel.fromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    } finally {
      isSuraDetaileLoading(false);
      update();
    }
  }
}
