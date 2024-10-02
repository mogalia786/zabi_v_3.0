import 'package:zabi/data/api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:zabi/data/model/response/dikir_list_model.dart';
import 'package:zabi/util/app_constants.dart';

class DikirListController extends GetxController implements GetxService {
  final ApiClient apiClient;
  DikirListController({required this.apiClient});
  @override
  void onInit() {
    // fetchDikirListData();
    super.onInit();
  }

// local variable
  RxBool isDikirListLoading = false.obs;
  DikirListModel? dikirListApiData;

// get dua list form here
  Future<void> fetchDikirListData({String? translatorId}) async {
    try {
      isDikirListLoading(true);

      final response = await apiClient.getData(AppConstants.DIKIR_LIST);

      if (response.statusCode == 200) {
        dikirListApiData = DikirListModel.fromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    } finally {
      isDikirListLoading(false);
      update();
    }
  }
}
