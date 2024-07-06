// To parse this JSON data, do
//
//     final currencyModel = currencyModelFromJson(jsonString);

import 'dart:convert';

List<CurrencyModel> currencyModelFromJson(String str) => List<CurrencyModel>.from(json.decode(str).map((x) => CurrencyModel.fromJson(x)));

String currencyModelToJson(List<CurrencyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurrencyModel {
  int? id;
  String? code;
  String? ccy;
  String? ccyNmRu;
  String? ccyNmUz;
  String? ccyNmUzc;
  String? ccyNmEn;
  String? nominal;
  String? rate;
  String? diff;
  String? date;

  CurrencyModel({
    required this.id,
    required this.code,
    required this.ccy,
    required this.ccyNmRu,
    required this.ccyNmUz,
    required this.ccyNmUzc,
    required this.ccyNmEn,
    required this.nominal,
    required this.rate,
    required this.diff,
    required this.date,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
    id: json["id"],
    code: json["Code"],
    ccy: json["Ccy"],
    ccyNmRu: json["CcyNm_RU"],
    ccyNmUz: json["CcyNm_UZ"],
    ccyNmUzc: json["CcyNm_UZC"],
    ccyNmEn: json["CcyNm_EN"],
    nominal: json["Nominal"],
    rate: json["Rate"],
    diff: json["Diff"],
    date: json["Date"]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Code": code,
    "Ccy": ccy,
    "CcyNm_RU": ccyNmRu,
    "CcyNm_UZ": ccyNmUz,
    "CcyNm_UZC": ccyNmUzc,
    "CcyNm_EN": ccyNmEn,
    "Nominal": nominal,
    "Rate": rate,
    "Diff": diff,
    "Date": dateValues.reverse[date],
  };
}

enum Date {
  THE_08012024
}

final dateValues = EnumValues({
  "08.01.2024": Date.THE_08012024
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
