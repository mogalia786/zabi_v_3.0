// dhikr_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabi/data/model/response/local_dhikr_model.dart';

class LocalDhikrController extends GetxController {
  var count = 0.obs;
  var dhikrList = <LocalDhikrModel>[].obs;
  String? dhikrId;

  Future<void> loadCount(String dhikrId) async {
    int loadedCount = await LocalDhikrStorage.getDhikrCount(dhikrId);
    count.value = loadedCount;
  }

  Future<void> incrementCount(String dhikrId) async {
    await LocalDhikrStorage.incrementDhikrCount(dhikrId);
    await loadCount(dhikrId);
  }

  Future<void> deleteCount(String dhikrId) async {
    await LocalDhikrStorage.deleteDhikrCount(dhikrId);
    count.value = 0;
  }

  void deleteDhikr(String dhikrId) {
    dhikrList.removeWhere((dhikr) => dhikr.id == dhikrId);
    LocalDhikrStorage.saveDhikrList(dhikrList);
  }

  void addDhikr(
    String englishName,
    String arabicName,
    String englishDescription,
    String arabicDescription,
  ) {
    final dhikrId = DateTime.now().millisecondsSinceEpoch.toString();
    dhikrList.add(LocalDhikrModel(
      id: dhikrId,
      englishName: englishName,
      arabicName: arabicName,
      englishDescription: englishDescription,
      arabicDescription: arabicDescription,
    ));

    LocalDhikrStorage.saveDhikrList(dhikrList);
  }

  void loadDhikrList() {
    LocalDhikrStorage.loadDhikrList().then((savedList) {
      dhikrList.assignAll(savedList);
    });
  }
}

class LocalDhikrStorage {
  static const dhikrListKey = 'dhikr_list';

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

  static Future<void> saveDhikrList(List<LocalDhikrModel> dhikrList) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(dhikrList.map((dhikr) => dhikr.toJson()).toList());
    prefs.setString(dhikrListKey, jsonString);
  }

  static Future<List<LocalDhikrModel>> loadDhikrList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(dhikrListKey);
    if (jsonString != null) {
      final List<dynamic> decodedList = jsonDecode(jsonString);
      return decodedList.map((item) => LocalDhikrModel.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}
