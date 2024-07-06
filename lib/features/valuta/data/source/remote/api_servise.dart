import '../model/response/currency_model.dart';

abstract class ApiServise {
  Future<List<CurrencyModel>> getCurrencyData(String data);
}
