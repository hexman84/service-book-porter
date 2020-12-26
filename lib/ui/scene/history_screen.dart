import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:servicebook/bloc/history_order_details/history_order_details_bloc.dart';
import 'package:servicebook/models/order.dart';
import 'package:servicebook/resources/resources.dart';
import 'package:servicebook/ui/widgets/history_order_card.dart';
import 'package:servicebook/ui/widgets/history_order_details.dart';
import 'package:servicebook/ui/widgets/logged_user_display_name.dart';
import 'package:servicebook/ui/widgets/logout.dart';
import 'package:servicebook/ui/widgets/order_list_header.dart';
import 'package:servicebook/ui/widgets/screen_buttons.dart';
import 'package:servicebook/ui/widgets/service_book_app_bar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundScaffold,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ServiceBookLogo(),
                  ScreenButtons(
                    historyPage: true,
                  ),
                  LoggedUserName(),
                  LogOut(),
                ],
              ),
            ),
            elevation: 0,
            backgroundColor: AppColors.white,
          ),
        ),
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ValueListenableBuilder(
                  valueListenable: Hive.box<Order>('ordersHistory').listenable(),
                  builder: (context, Box<Order> box, _) {
                    if (box.values.isEmpty) {
                      return Center(
                        child: Text('История заказов отсутствует', style: AppTextStyles.regularStyle),
                      );
                    } else {
                      List<Order> orders = box.values.toList().reversed.toList();
                      orders.sort((a, b) => b.createDate.compareTo(a.createDate));
                      Map<String, List<Order>> resultOrders = orders.fold<Map<String, List<Order>>>({}, (days, order) {
                        initializeDateFormatting('ru');
                        String currDay = DateFormat('d MMMM yyyy', 'ru').format(DateTime.parse(order.createDate));
                        if (days[currDay] == null) {
                          days[currDay] = [];
                        }
                        days[currDay].add(order);
                        return days;
                      });
                      return ListView.builder(
                        itemCount: resultOrders.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          List keys = resultOrders.keys.toList();
                          return Container(
                            width: MediaQuery.of(context).size.width * 4 / 13,
                            child: Column(
                              children: <Widget>[
                                OrderListHeader(
                                  header: keys[i],
                                ),
                                Expanded(
                                  child: ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 31,
                                      horizontal: 19,
                                    ),
                                    physics: BouncingScrollPhysics(),
                                    itemCount: resultOrders[keys[i]].length,
                                    itemBuilder: (context, p) {
                                      List<Order> orders = resultOrders[keys[i]];
                                      return HistoryOrderCard(order: orders[p]);
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(height: 31);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: BlocBuilder<HistoryOrderDetailsBloc, HistoryOrderDetailsState>(
                builder: (context, state) {
                  if (state is HistoryOrderDetailsInitial) {
                    return Container(color: AppColors.white);
                  }
                  if (state is ShowHistoryOrderDetails) {
                    return HistoryOrderDetails(
                      order: state.order,
                      date: state.date,
                      totalCost: state.totalCost,
                      user: state.user,
                      orderPosition: state.orderPositions,
                      orgNames: state.orgNames,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
