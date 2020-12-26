import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:servicebook/models/order.dart';
import 'package:servicebook/models/order_positions.dart';
import 'package:servicebook/models/organization.dart';
import 'package:servicebook/models/user.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

part 'history_order_details_event.dart';
part 'history_order_details_state.dart';

class HistoryOrderDetailsBloc extends Bloc<HistoryOrderDetailsEvent, HistoryOrderDetailsState> {

  @override
  HistoryOrderDetailsState get initialState => HistoryOrderDetailsInitial();

  @override
  Stream<HistoryOrderDetailsState> mapEventToState(
    HistoryOrderDetailsEvent event,
  ) async* {
    if (event is AddHistoryOrderDetailsToDisplay) {
      yield* _mapShowOrderToState(event);
    }
  }

  Stream<HistoryOrderDetailsState> _mapShowOrderToState(AddHistoryOrderDetailsToDisplay event) async* {
    final ordersBox = Hive.box<Order>('ordersHistory');
    final userBox = Hive.box<User>('allUsers');
    final organizationsBox = Hive.box<Organization>('organizations');
    Order order = ordersBox.values.firstWhere((item) => item.zakazKey == event.zakazKey);
    User currUser = userBox.values.firstWhere((user) => user.userId == order.userId,
        orElse: () => User(userName: 'Заказ юзера, которого нет', userPhone: '79999999999'));
    String date = formatDate(order.createDate);
    order.positions.sort((a, b) => a.orgid.compareTo(b.orgid));
    List orgIds = order.positions.map((e) => e.orgid).toSet().toList();
    List<List<OrderPositions>> orderPositions = [];
    orgIds.forEach((orgId) => orderPositions.add([...order.positions.where((order) => order.orgid == orgId)]));
    List<Organization> orgNames = [];
    orgIds.forEach((orgId) => orgNames.addAll(organizationsBox.values.toList().where((org) => orgId == org.id)));
    double totalCost = order.positions.fold(0, (a, b) => a + b.price);
    yield ShowHistoryOrderDetails(
      order: order,
      date: date,
      totalCost: totalCost,
      user: currUser,
      orderPositions: orderPositions,
      orgNames: orgNames,
    );
  }

  String formatDate(String createDate) {
    initializeDateFormatting('ru');
    String date = DateFormat('d, EEE, MMMM yyyy, HH:mm', 'ru').format(DateTime.parse(createDate).add(Duration(hours: 3)));
    date =
    '${date.substring(0, date.indexOf(',') + 2)}${date[date.indexOf(',') + 2].toUpperCase()}${date.substring(date.indexOf(',') + 3, date.indexOf(',', 4) + 2)}${date[date.indexOf(',', 3) + 2].toUpperCase()}${date.substring(date.indexOf(',', 3) + 3)}';
    String month = date.substring(
        date.indexOf(',', date.indexOf(',') + 1) + 2, date.indexOf(' ', date.indexOf(',', date.indexOf(',') + 1) + 2));
    if (month.contains('я')) {
      if (month.length == 3) {
        month = month.replaceRange(month.length - 1, month.length, 'й');
      } else {
        month = month.replaceRange(month.length - 1, month.length, 'ь');
      }
    } else {
      month = month.replaceRange(month.length - 1, month.length, '');
    }
    date = date.replaceRange(
      date.indexOf(',', date.indexOf(',') + 1) + 2,
      date.indexOf(' ', date.indexOf(',', date.indexOf(',') + 1) + 2),
      month,
    );
    return date;
  }
}
