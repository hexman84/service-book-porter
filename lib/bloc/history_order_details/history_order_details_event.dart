part of 'history_order_details_bloc.dart';

abstract class HistoryOrderDetailsEvent extends Equatable {
  const HistoryOrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class AddHistoryOrderDetailsToDisplay extends HistoryOrderDetailsEvent {
  final int zakazKey;

  AddHistoryOrderDetailsToDisplay({this.zakazKey});

  @override
  List<Object> get props => [zakazKey];
}
