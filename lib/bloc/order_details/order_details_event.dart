import 'package:equatable/equatable.dart';
import 'package:servicebook/models/order.dart';

abstract class OrderDetailsEvent extends Equatable {
  const OrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class AddOrderDetailsToDisplay extends OrderDetailsEvent {
  final int zakazKey;

  AddOrderDetailsToDisplay({this.zakazKey});

  @override
  List<Object> get props => [zakazKey];
}

class ModifyOrderPositionStatus extends OrderDetailsEvent {
  final String orderPositionId;
  final bool status;

  ModifyOrderPositionStatus({this.orderPositionId, this.status});

  @override
  List<Object> get props => [orderPositionId, status];
}

class ChangeOrderStatusToInWork extends OrderDetailsEvent {
  final Order order;

  ChangeOrderStatusToInWork({this.order});

  @override
  List<Object> get props => [order];
}

class ChangeOrderStatusToDone extends OrderDetailsEvent {
  final Order order;

  ChangeOrderStatusToDone({this.order});

  @override
  List<Object> get props => [order];
}

class ChangeOrderStatusToCanceled extends OrderDetailsEvent {
  final Order order;

  ChangeOrderStatusToCanceled({this.order});

  @override
  List<Object> get props => [order];
}

class RemoveOrderFromState extends OrderDetailsEvent {}
