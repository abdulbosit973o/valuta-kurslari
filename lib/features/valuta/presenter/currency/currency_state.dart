part of 'currency_bloc.dart';

class CurrencyState {
  final Status? status;
  final List<CurrencyModel>? data;

  CurrencyState({this.status, this.data});

  CurrencyState copyWith({Status? status, List<CurrencyModel>? data}) =>
      CurrencyState(status: status ?? this.status, data: data ?? this.data);
}

