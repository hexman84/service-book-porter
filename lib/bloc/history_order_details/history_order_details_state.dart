part of 'history_order_details_bloc.dart';

abstract class HistoryOrderDetailsState extends Equatable {
  const HistoryOrderDetailsState();

  @override
  List<Object> get props => [];
}

class HistoryOrderDetailsInitial extends HistoryOrderDetailsState {}

class ShowHistoryOrderDetails extends HistoryOrderDetailsState {
  final Order order;
  final String date;
  final double totalCost;
  final User user;
  final List<List<OrderPositions>> orderPositions;
  final List<Organization> orgNames;

  ShowHistoryOrderDetails({
    this.order,
    this.date,
    this.totalCost,
    this.user,
    this.orderPositions,
    this.orgNames,
  });

  @override
  List<Object> get props => [
    order,
    date,
    totalCost,
    user,
    orderPositions,
    orgNames,
  ];
}
