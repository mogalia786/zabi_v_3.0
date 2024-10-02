import 'package:zabi/data/api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:zabi/data/model/response/dua_details_model.dart';
import 'package:zabi/util/app_constants.dart';

class DuaDetailsController extends GetxController implements GetxService {
  final ApiClient apiClient;
  DuaDetailsController({required this.apiClient});
  // local variable
  RxBool isDuaDetailsLoading = false.obs;
  DuaDetailsModel? duaDetailApiData;

// get dua details function
  Future<void> fetchDuaDetailsData({String? duaId}) async {
    try {
      isDuaDetailsLoading(true);

      final response =
          await apiClient.getData(AppConstants.DUA_DETAILES + duaId.toString());

      if (response.statusCode == 200) {
        duaDetailApiData = DuaDetailsModel.fromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    } finally {
      isDuaDetailsLoading(false);
      update();
    }
  }
}
