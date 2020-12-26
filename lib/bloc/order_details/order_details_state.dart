import 'package:equatable/equatable.dart';
import 'package:servicebook/models/order.dart';
import 'package:servicebook/models/order_positions.dart';
import 'package:servicebook/models/organization.dart';
import 'package:servicebook/models/user.dart';

abstract class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object> get props => [];
}

class InitialOrderDetailsState extends OrderDetailsState {}

class ShowOrderDetails extends OrderDetailsState {
  final Order order;
  final String date;
  final double totalCost;
  final User user;
  final List<List<OrderPositions>> orderPositions;
  final List<Organization> orgNames;

  ShowOrderDetails({
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
