import 'package:zabi/data/api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:zabi/data/model/response/sura_list_model.dart';
import 'package:zabi/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuraListController extends GetxController implements GetxService {
  final ApiClient apiClient;
  SuraListController({required this.apiClient});
  @override
  void onInit() {
    fetchSuraListData();
    super.onInit();
  }

// local variable
  RxBool isSuraListLoading = false.obs;
  SuraListModel? suraListApiData;

// get sura list function
  Future<void> fetchSuraListData({String? translatorId}) async {
    try {
      isSuraListLoading(true);
      final prefs = await SharedPreferences.getInstance();
      var selectedTranslatorId =
          translatorId ?? prefs.getString('selectedTranslatorId') ?? 1;

      final response = await apiClient.getData(AppConstants.SURA_LIST +
          AppConstants.TRANSLATOR_ID +
          selectedTranslatorId.toString(),

      );

      if (response.statusCode == 200) {
        suraListApiData = SuraListModel.fromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    } finally {
      isSuraListLoading(false);
      update();
    }
  }
}
