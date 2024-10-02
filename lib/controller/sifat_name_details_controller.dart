import 'package:zabi/data/api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:zabi/data/model/response/sifat_name_details_model.dart';
import 'package:zabi/util/app_constants.dart';

class SifatNameDetailsController extends GetxController implements GetxService {
  final ApiClient apiClient;
  SifatNameDetailsController({required this.apiClient});
  // local variable
  RxBool isSifatNameDetailsLoading = false.obs;
  SifatNameDetailsModel? sifatnameDetailsApidata;

// get dua details function
  Future<void> fetchSifatNameDetailsData({String? sifatNameId}) async {
    try {
      isSifatNameDetailsLoading(true);

      final response = await apiClient
          .getData(AppConstants.SIFAT_NAME_DETAILES + sifatNameId.toString());

      if (response.statusCode == 200) {
        sifatnameDetailsApidata = SifatNameDetailsModel.fromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    } finally {
      isSifatNameDetailsLoading(false);
      update();
    }
  }
}
