// ignore_for_file: non_constant_identifier_names

class BookMark {
  int id;
  String serialNumber;
  String suraName;
  String versesNumber;
  String arabicName;
  String translatedName;
  String pageNumber;

  BookMark({
    required this.id,
    required this.serialNumber,
    required this.suraName,
    required this.versesNumber,
    required this.arabicName,
    required this.translatedName,
    required this.pageNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serial_number': serialNumber,
      'sura_name': suraName,
      'verses_number': versesNumber,
      'arabic_name': arabicName,
      'translated_name': translatedName,
      'page_number': pageNumber,
    };
  }

  factory BookMark.fromMap(Map<String, dynamic> map) {
    return BookMark(
      id: map['id'],
      serialNumber: map['serial_number'],
      suraName: map['sura_name'],
      versesNumber: map['verses_number'],
      arabicName: map['arabic_name'],
      translatedName: map['translated_name'],
      pageNumber: map['page_number'],
    );
  }
}
