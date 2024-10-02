import 'package:zabi/data/api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:zabi/data/model/response/dua_list_model.dart';
import 'package:zabi/util/app_constants.dart';

class DuaListController extends GetxController implements GetxService {
  final ApiClient apiClient;
  DuaListController({required this.apiClient});
  @override
  void onInit() {
    // fetchDuaListData();
    super.onInit();
  }

// local variable
  RxBool isDuaListLoading = false.obs;
  DuaListModel? duaApiData;

// get dua list form here
  Future<void> fetchDuaListData({String? translatorId}) async {
    try {
      isDuaListLoading(true);

      final response = await apiClient.getData(AppConstants.DUA_LIST);

      if (response.statusCode == 200) {
        duaApiData = DuaListModel.fromJson(response.body);
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
