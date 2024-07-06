import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:dio/dio.dart';

import '../model/response/currency_model.dart';
import 'api_servise.dart';

class ApiServiseImpl extends ApiServise {
  final _dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: 'https://cbu.uz',
      contentType: 'application/json',

      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60)));

  Future<List<CurrencyModel>> getCurrency() async {
    try {
      _dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printRequestData: true,
            printResponseData: true,
            printResponseHeaders: true,
            printResponseMessage: true,
          ),
        ),
      );

      final response = await _dio.get('/uz/arkhiv-kursov-valyut/json/');
      return (response.data as List).map((e) => CurrencyModel.fromJson(e)).toList();

    } on DioException catch (e) {
      return [];
    }
  }
  Future<List<CurrencyModel>> getCurrencyData(String data) async {
    try {
      _dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printRequestData: true,
            printResponseData: true,
            printResponseHeaders: true,
            printResponseMessage: true,
          ),
        ),
      );
      final response = await _dio.get('/uz/arkhiv-kursov-valyut/json/all/$data/');
      return (response.data as List).map((e) => CurrencyModel.fromJson(e)).toList();

    } on DioException catch (e) {
      return [];
    }
  }

}
