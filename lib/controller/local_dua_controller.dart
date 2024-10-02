// dhikr_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabi/data/model/response/local_dua_model.dart';

class LocalDuaController extends GetxController {
  var duaList = <LocalDuaModel>[].obs;
  String? duaId;

  void deleteDua(String duaId) {
    duaList.removeWhere((dua) => dua.id == duaId);
    LocalDuaStorage.saveDuaList(duaList);
  }

  void addDua(
    String englishName,
    String arabicName,
    String englishDescription,
    String arabicDescription,
  ) {
    final duaId = DateTime.now().millisecondsSinceEpoch.toString();
    duaList.add(LocalDuaModel(
      id: duaId,
      englishName: englishName,
      arabicName: arabicName,
      englishDescription: englishDescription,
      arabicDescription: arabicDescription,
    ));

    LocalDuaStorage.saveDuaList(duaList);
  }

  void loadDuaList() {
    LocalDuaStorage.loadDuaList().then((savedList) {
      duaList.assignAll(savedList);
    });
  }
}

class LocalDuaStorage {
  static const duaListKey = 'dua_list';

  static Future<void> deleteDuaCount(String duaId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(duaId);
  }

  static Future<void> saveDuaList(List<LocalDuaModel> duaList) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(duaList.map((dua) => dua.toJson()).toList());
    prefs.setString(duaListKey, jsonString);
  }

  static Future<List<LocalDuaModel>> loadDuaList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(duaListKey);
    if (jsonString != null) {
      final List<dynamic> decodedList = jsonDecode(jsonString);
      return decodedList.map((item) => LocalDuaModel.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}
