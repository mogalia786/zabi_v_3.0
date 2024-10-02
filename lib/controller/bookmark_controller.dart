import 'package:zabi/data/model/response/bookmark_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BookMarkController extends GetxController {
  // Data store by model
  List<BookMark> bookMarks = <BookMark>[];
  // Local variable
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookMarks();
  }

// data lode store function
  Future<void> loadBookMarks() async {
    isLoading.value = true;
    final Database db = await _initDatabase();
    final List<Map<String, dynamic>> bookMarkMaps = await db.query('bookMarks');
    bookMarks = bookMarkMaps.map((map) => BookMark.fromMap(map)).toList();

    if (kDebugMode) {
      print("bookmark Data ==> ${bookMarks.length}");
    }
    isLoading.value = false;
    update();
  }

// data stroge function
  Future<Database> _initDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'bookMarks.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE bookMarks(
            id INTEGER PRIMARY KEY,
            serial_number TEXT,
            sura_name TEXT,
            verses_number TEXT,
            arabic_name TEXT,
            translated_name TEXT,
            page_number TEXT
          )
        ''');
      },
    );
  }

// data insert function
  Future<void> insertBookMark(BookMark bookMark) async {
    update();
    final Database db = await _initDatabase();
    await db.insert('bookMarks', bookMark.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    loadBookMarks();
    Get.snackbar(
      "message".tr,
      "book_mark_successfully_added".tr,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
    update();
  }

// update function
  Future<void> updateBookMark(BookMark bookMark) async {
    final Database db = await _initDatabase();
    await db.update('bookMarks', bookMark.toMap(),
        where: 'id = ?', whereArgs: [bookMark.id]);
    loadBookMarks();
  }

// delete function
  Future<void> deleteBookMark(int id) async {
    final Database db = await _initDatabase();
    await db.delete('bookMarks', where: 'id = ?', whereArgs: [id]);
    loadBookMarks();
    Get.snackbar(
      "message".tr,
      "book_mark_successfully_added".tr,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
  }
}
