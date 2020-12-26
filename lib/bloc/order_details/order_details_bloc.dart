import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:servicebook/bloc/orders/bloc.dart';
import 'package:servicebook/models/order.dart';
import 'package:intl/intl.dart';
import 'package:servicebook/models/order_positions.dart';
import 'package:servicebook/models/organization.dart';
import 'package:servicebook/models/user.dart';
import 'package:servicebook/network/api.dart';
import './bloc.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  final API _api = API();
  final OrdersBloc ordersBloc;
  String selectedOrderId;

  OrderDetailsBloc({@required this.ordersBloc}) : assert(ordersBloc != null);

  @override
  OrderDetailsState get initialState => InitialOrderDetailsState();

  @override
  Stream<OrderDetailsState> mapEventToState(
    OrderDetailsEvent event,
  ) async* {
    final currentState = state;
    if (event is AddOrderDetailsToDisplay) {
      yield* _mapShowOrderToState(event);
    }
    if (event is ModifyOrderPositionStatus) {
      yield* _mapModifyOrderPosition(event, currentState);
    }
    if (event is RemoveOrderFromState) {
      yield InitialOrderDetailsState();
    }
    if (event is ChangeOrderStatusToInWork) {
      yield* _mapChangeOrderStatusToInWork(event, currentState);
    }
    if (event is ChangeOrderStatusToCanceled) {
      yield* _mapChangeOrderStatusToCanceled(event);
    }
    if (event is ChangeOrderStatusToDone) {
      yield* _mapChangeOrderStatusToDone(event);
    }
  }

  Stream<OrderDetailsState> _mapChangeOrderStatusToDone(ChangeOrderStatusToDone event) async* {
    Order currOrder = event.props[0];
    Set statuses = {};
    String resultOrderStatus;
    currOrder.positions.forEach((element) => statuses.add(element.completed));
    if (statuses.length == 1) {
      if (statuses.elementAt(0) == null || statuses.elementAt(0) == false) {
        resultOrderStatus = 'annulled';
      } else {
        resultOrderStatus = 'done';
      }
    }
    if (statuses.length == 2) {
      if (statuses.contains(true)) {
        resultOrderStatus = 'partially';
      } else {
        resultOrderStatus = 'annulled';
      }
    }
    if (statuses.length == 3) {
      resultOrderStatus = 'partially';
    }
    final token = Hive.box('importantData').get('token');
    bool statusChanged = await _api.changeOrderStatus(token: token, orderId: currOrder.id, newStatus: resultOrderStatus);
    if (statusChanged) {
      yield InitialOrderDetailsState();
      currOrder.status = resultOrderStatus;
      currOrder.delete();
      final ordersHistoryBox = Hive.box<Order>('ordersHistory');
      ordersHistoryBox.add(currOrder);
      ordersBloc.add(ReShowOrdersData());
    }
  }

  Stream<OrderDetailsState> _mapChangeOrderStatusToCanceled(ChangeOrderStatusToCanceled event) async* {
    Order currOrder = event.props[0];
    final token = Hive.box('importantData').get('token');
    bool statusChanged = await _api.changeOrderStatus(token: token, orderId: currOrder.id, newStatus: 'annulled');
    if (statusChanged) {
      yield InitialOrderDetailsState();
      currOrder.status = 'annulled';
      currOrder.delete();
      final ordersHistoryBox = Hive.box<Order>('ordersHistory');
      ordersHistoryBox.add(currOrder);
      ordersBloc.add(ReShowOrdersData());
    }
  }

  Stream<OrderDetailsState> _mapChangeOrderStatusToInWork(
      ChangeOrderStatusToInWork event, OrderDetailsState state) async* {
    Order currOrder = event.props[0];
    final token = Hive.box('importantData').get('token');
    bool statusChanged = await _api.changeOrderStatus(token: token, orderId: currOrder.id, newStatus: 'inwork');
    if (statusChanged) {
      currOrder.status = 'inwork';
      currOrder.save();
      ordersBloc.add(ReShowOrdersData());
      yield InitialOrderDetailsState();
      yield ShowOrderDetails(
        order: state.props[0],
        date: state.props[1],
        totalCost: state.props[2],
        user: state.props[3],
        orderPositions: state.props[4],
        orgNames: state.props[5],
      );
    }
  }

  Stream<OrderDetailsState> _mapShowOrderToState(AddOrderDetailsToDisplay event) async* {
    final ordersBox = Hive.box<Order>('activeOrders');
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
    selectedOrderId = order.id;
    print('${order.createDate} ${order.releaseDate} ${order.finishDate}');
    yield ShowOrderDetails(
      order: order,
      date: date,
      totalCost: totalCost,
      user: currUser,
      orderPositions: orderPositions,
      orgNames: orgNames,
    );
  }

  Stream<OrderDetailsState> _mapModifyOrderPosition(ModifyOrderPositionStatus event, OrderDetailsState state) async* {
    final ordersBox = Hive.box<Order>('activeOrders');
    Order currOrder = state.props[0];
    Order currOrderFromBox = ordersBox.values.toList().firstWhere((order) => order.zakazKey == currOrder.zakazKey);
    currOrderFromBox.positions.firstWhere((element) => element.id == event.orderPositionId).completed = event.status;
    currOrderFromBox.save();
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
