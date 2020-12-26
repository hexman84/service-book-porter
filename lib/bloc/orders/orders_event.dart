import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class FetchOrdersData extends OrdersEvent {
  final bool hideLoading;

  FetchOrdersData({this.hideLoading});

  @override
  List<Object> get props => [hideLoading];
}

class DeleteOrdersData extends OrdersEvent {}

class RefreshOrdersData extends OrdersEvent {}

class ReShowOrdersData extends OrdersEvent {}
