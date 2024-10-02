import 'package:zabi/data/api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:zabi/data/model/response/juz_list_model.dart';
import 'package:zabi/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JuzListController extends GetxController implements GetxService {
  final ApiClient apiClient;
  JuzListController({required this.apiClient});
  @override
  void onInit() {
    fetchJuzListData();
    super.onInit();
  }

// local variable
  RxBool isJuzListLoading = false.obs;
  JuzListModel? juzListApiData;

// get juz list form here
  Future<void> fetchJuzListData({String? translatorId}) async {
    try {
      isJuzListLoading(true);
      final prefs = await SharedPreferences.getInstance();
      var selectedTranslatorId =
          translatorId ?? prefs.getString('selectedTranslatorId') ?? 1;

      final response = await apiClient.getData(AppConstants.JUZ_LIST +
          AppConstants.TRANSLATOR_ID +
          selectedTranslatorId.toString());

      if (response.statusCode == 200) {
        juzListApiData = JuzListModel.fromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    } finally {
      isJuzListLoading(false);
      update();
    }
  }
}
