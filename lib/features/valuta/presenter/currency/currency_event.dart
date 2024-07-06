part of 'currency_bloc.dart';

@immutable
abstract class CurrencyEvent {}

class InitialCurrencyEvent extends CurrencyEvent {
  String date;

  InitialCurrencyEvent({required this.date});
}
