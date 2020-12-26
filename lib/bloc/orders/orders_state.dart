import 'package:equatable/equatable.dart';
import 'package:servicebook/models/order.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersEmpty extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersError extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<Order> newOrders;
  final List<Order> inWorkOrders;

  const OrdersLoaded({ this.newOrders, this.inWorkOrders});

  @override
  List<Object> get props => [newOrders, inWorkOrders];
}
