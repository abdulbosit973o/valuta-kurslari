// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "currency": "Currency",
  "eng": "English",
  "ru": "Русский",
  "uz": "Uzbek",
  "count": "count"
};
static const Map<String,dynamic> ru = {
  "currency": "валюта",
  "eng": "Aнглийский",
  "ru": "Русский",
  "uz": "узбекский",
  "count": "считать"
};
static const Map<String,dynamic> uz = {
  "currency": "Valyuta",
  "eng": "Inglizcha",
  "ru": "Ruscha",
  "uz": "O'zbekcha",
  "count": "hisoblash"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru, "uz": uz};
}
