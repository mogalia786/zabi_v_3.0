import 'package:zabi/data/api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:zabi/data/model/response/sifat_name_list_model.dart';
import 'package:zabi/util/app_constants.dart';

class SifatNameListController extends GetxController implements GetxService {
  final ApiClient apiClient;
  SifatNameListController({required this.apiClient});
  @override
  void onInit() {
    // fetchSifatNameListData();
    super.onInit();
  }

// local variable
  RxBool isSifatNameListLoading = false.obs;
  SifatNameListModel? sifatNameApiData;

// get dua list form here
  Future<void> fetchSifatNameListData() async {
    try {
      isSifatNameListLoading(true);

      final response = await apiClient.getData(AppConstants.SIFAT_NAME_LIST);

      if (response.statusCode == 200) {
        sifatNameApiData = SifatNameListModel.fromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    } finally {
      isSifatNameListLoading(false);
      update();
    }
  }
}
