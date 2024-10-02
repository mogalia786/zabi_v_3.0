import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabi/data/api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:zabi/data/model/response/dikir_details_model.dart';
import 'package:zabi/util/app_constants.dart';

class DikirDetailsController extends GetxController implements GetxService {
  final ApiClient apiClient;
  DikirDetailsController({required this.apiClient});
  // local variable
  RxBool isDikirDetailsLoading = false.obs;
  DikirDetailsModel? dikirDetailApiData;

// get dua details function
  Future<void> fetchDikirDetailsData({String? dikirId}) async {
    try {
      isDikirDetailsLoading(true);

      final response = await apiClient
          .getData(AppConstants.DIKIR_DETAILES + dikirId.toString());

      if (response.statusCode == 200) {
        dikirDetailApiData = DikirDetailsModel.fromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    } finally {
      isDikirDetailsLoading(false);
      update();
    }
  }

  ////////////////////////////////////////////

  String? dikirId;
  var count = 0.obs;

  Future<void> loadCount(String dhikrId) async {
    int loadedCount = await LocalStorage.getDhikrCount(dhikrId);
    count.value = loadedCount;
  }

  Future<void> incrementCount(String dhikrId) async {
    await LocalStorage.incrementDhikrCount(dhikrId);
    await loadCount(dhikrId);
  }

  Future<void> deleteCount(String dhikrId) async {
    await LocalStorage.deleteDhikrCount(dhikrId);
    count.value = 0;
  }
}

class LocalStorage {
  static Future<int> getDhikrCount(String dhikrId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(dhikrId) ?? 0;
  }

  static Future<void> incrementDhikrCount(String dhikrId) async {
    final prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt(dhikrId) ?? 0;
    count++;
    prefs.setInt(dhikrId, count);
  }

  static Future<void> deleteDhikrCount(String dhikrId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(dhikrId);
  }
}
