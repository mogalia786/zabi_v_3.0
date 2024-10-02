class MosqueSettingsModel {
  bool? status;
  String? message;
  Data? data;

  MosqueSettingsModel({this.status, this.message, this.data});

  MosqueSettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? mosqueName;
  String? mosqueAddress;
  String? appLogo;
  dynamic zakatNisab;
  String? zakatDescription;
  String? haramDescription;
  bool? automaticPayerTime;
  bool? ramadanSchedule;
  String? currencySymbol;
  String? playStoreUrl;
  String? appStoreUrl;

  Data(
      {this.mosqueName,
      this.mosqueAddress,
      this.appLogo,
      this.zakatNisab,
      this.zakatDescription,
      this.haramDescription,
      this.automaticPayerTime,
      this.ramadanSchedule,
      this.currencySymbol,
      this.playStoreUrl,
      this.appStoreUrl});

  Data.fromJson(Map<String, dynamic> json) {
    mosqueName = json['mosque_name'];
    mosqueAddress = json['mosque_address'];
    appLogo = json['app_logo'];
    zakatNisab = json['zakat_nisab'];
    zakatDescription = json['zakat_description'];
    haramDescription = json['haram_description'];
    automaticPayerTime = json['automatic_payer_time'];
    ramadanSchedule = json['ramadan_schedule'];
    currencySymbol = json['currency_symbol'];
    playStoreUrl = json['play_store_url'];
    appStoreUrl = json['app_store_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mosque_name'] = mosqueName;
    data['mosque_address'] = mosqueAddress;
    data['app_logo'] = appLogo;
    data['zakat_nisab'] = zakatNisab;
    data['zakat_description'] = zakatDescription;
    data['haram_description'] = haramDescription;
    data['automatic_payer_time'] = automaticPayerTime;
    data['ramadan_schedule'] = ramadanSchedule;
    data['currency_symbol'] = currencySymbol;
    data['play_store_url'] = playStoreUrl;
    data['app_store_url'] = appStoreUrl;
    return data;
  }
}
