import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:servicebook/models/order.dart';
import 'package:servicebook/models/organization.dart';
import 'package:servicebook/network/api.dart';
import './bloc.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final API _api = API();
  final activeOrders = Hive.box<Order>('activeOrders');

  @override
  OrdersState get initialState => OrdersEmpty();

  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    if (event is FetchOrdersData) {
      yield* _mapOrdersLoadedToState(hideLoading: event.hideLoading ?? false);
    }
    if (event is DeleteOrdersData) {
      yield OrdersEmpty();
    }
    if (event is ReShowOrdersData) {
      yield OrdersEmpty();
      yield OrdersLoaded(
        newOrders: activeOrders.values.toList().where((order) => order.status == 'confirmed').toList(),
        inWorkOrders: activeOrders.values.toList().where((order) => order.status == 'inwork').toList(),
      );
    }
  }

  Stream<OrdersState> _mapOrdersLoadedToState({bool hideLoading = false}) async* {
    if (!hideLoading) {
      yield OrdersLoading();
    }
    try {
      final organizationsBox = Hive.box<Organization>('organizations');
      final token = Hive.box('importantData').get('token');
      List<Order> orders = await _api.getOrders(token);
      List<Organization> organizations = await _api.getOrganizations(token);
      for (Order newOrder in orders) {
        if (!activeOrders.values.contains(newOrder)) {
          activeOrders.add(newOrder);
        }
      }
      await organizationsBox.clear();
      organizationsBox.addAll(organizations);
      // может тут потом отойти от отображения стейта с заказами
      // по пустому стейту показывать через watchbox в интерфейсе
      yield OrdersEmpty();
      yield OrdersLoaded(
        newOrders: activeOrders.values.toList().where((order) => order.status == 'confirmed').toList(),
        inWorkOrders: activeOrders.values.toList().where((order) => order.status == 'inwork').toList(),
      );
    } catch (_) {
      yield OrdersError();
    }
  }
}
