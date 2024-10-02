import 'package:zabi/data/api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:zabi/data/model/response/mosque_settings_model.dart';
import 'package:zabi/util/app_constants.dart';

class MosqueSettingsController extends GetxController implements GetxService {
  final ApiClient apiClient;
  MosqueSettingsController({required this.apiClient});
  @override
  void onInit() {
    // fetchMosqueSettingsData();
    super.onInit();
  }

// local variable
  RxBool isMosqueSettingsLoading = false.obs;
  MosqueSettingsModel? mosqueSettingsApiData;

// get juz list form here
  Future<void> fetchMosqueSettingsData({String? translatorId}) async {
    try {
      isMosqueSettingsLoading(true);

      final response = await apiClient.getData(AppConstants.MOSQUE_SETTINGS);

      if (response.statusCode == 200) {
        mosqueSettingsApiData = MosqueSettingsModel.fromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    } finally {
      isMosqueSettingsLoading(false);
      update();
    }
  }
}
