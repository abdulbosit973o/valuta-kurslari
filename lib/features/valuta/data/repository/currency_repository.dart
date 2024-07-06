
import '../source/model/response/currency_model.dart';

abstract class CurrencyRepository{
  Future<List<CurrencyModel>> getCurrency(String data);
}