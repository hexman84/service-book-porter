import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:servicebook/bloc/order_details/bloc.dart';
import 'package:servicebook/bloc/orders/bloc.dart';
import 'package:servicebook/resources/resources.dart';
import 'package:servicebook/ui/widgets/in_work_order_card.dart';
import 'package:servicebook/ui/widgets/logged_user_display_name.dart';
import 'package:servicebook/ui/widgets/logout.dart';
import 'package:servicebook/ui/widgets/order_details.dart';
import 'package:servicebook/ui/widgets/screen_buttons.dart';
import 'package:servicebook/ui/widgets/service_book_app_bar.dart';
import 'package:servicebook/ui/widgets/order_list_header.dart';
import 'package:servicebook/ui/widgets/new_order_card.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final int createTime = Hive.box('importantData').get('create_time');

  final int readyTime = Hive.box('importantData').get('ready_time');

  bool showDelayedOrders = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundScaffold,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ServiceBookLogo(),
                  IconButton(
                    icon: Icon(Icons.error),
                    onPressed: () => showDelayedOrders = !showDelayedOrders,
                  ),
                  ScreenButtons(
                    ordersPage: true,
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
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    OrderListHeader(
                      header: AppStrings.newOrders,
                    ),
                    BlocBuilder<OrdersBloc, OrdersState>(
                      builder: (context, state) {
                        if (state is OrdersLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is OrdersError) {
                          return Center(child: Text('error'));
                        }
                        if (state is OrdersLoaded) {
                          if (state.newOrders.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .33),
                              child: Text(
                                'Заказов нет',
                                style: AppTextStyles.regularStyle,
                              ),
                            );
                          }
                          return Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                vertical: 31,
                                horizontal: 19,
                              ),
                              physics: BouncingScrollPhysics(),
                              itemCount: state.newOrders.length,
                              itemBuilder: (context, index) {
                                return NewOrderCard(
                                  key: UniqueKey(),
                                  order: state.newOrders[index],
                                  createTime: createTime,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 31);
                              },
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: <Widget>[
                    OrderListHeader(
                      header: AppStrings.inWorkOrders,
                    ),
                    BlocBuilder<OrdersBloc, OrdersState>(
                      builder: (context, state) {
                        if (state is OrdersLoading) {
                          return CircularProgressIndicator();
                        }
                        if (state is OrdersError) {
                          return Text('error');
                        }
                        if (state is OrdersLoaded) {
                          if (state.inWorkOrders.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .33),
                              child: Text(
                                'Заказов нет',
                                style: AppTextStyles.regularStyle,
                              ),
                            );
                          }
                          return Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                vertical: 31,
                                horizontal: 19,
                              ),
                              physics: BouncingScrollPhysics(),
                              itemCount: state.inWorkOrders.length,
                              itemBuilder: (context, index) {
                                return InWorkOrderCard(
                                  key: UniqueKey(),
                                  order: state.inWorkOrders[index],
                                  readyTime: readyTime,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 31);
                              },
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
                builder: (context, state) {
                  if (state is InitialOrderDetailsState) {
                    return Container(color: AppColors.white);
                  }
                  if (state is ShowOrderDetails) {
                    return OrderDetails(
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
