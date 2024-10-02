import 'package:zabi/data/api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:zabi/data/model/response/haram_food_list_model.dart';
import 'package:zabi/util/app_constants.dart';

class HaramFoodListController extends GetxController implements GetxService {
  final ApiClient apiClient;
  HaramFoodListController({required this.apiClient});
  @override
  void onInit() {
    // fetchHaramFoodListData();
    super.onInit();
  }

// local variable
  RxBool isDuaListLoading = false.obs;
  HaramFoodListModel? haramFoodListApiData;

// get dua list form here
  Future<void> fetchHaramFoodListData({String? translatorId}) async {
    try {
      isDuaListLoading(true);

      final response = await apiClient.getData(AppConstants.HARAM_FOOD_LIST);

      if (response.statusCode == 200) {
        haramFoodListApiData = HaramFoodListModel.fromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    } finally {
      isDuaListLoading(false);
      update();
    }
  }
}
