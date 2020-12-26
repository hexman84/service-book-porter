import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicebook/bloc/order_details/bloc.dart';
import 'package:servicebook/models/order.dart';
import 'package:servicebook/models/order_positions.dart';
import 'package:servicebook/models/organization.dart';
import 'package:servicebook/models/user.dart';
import 'package:servicebook/resources/resources.dart';
import 'package:servicebook/ui/widgets/order_positions_list_view.dart';

class OrderDetails extends StatelessWidget {
  final Order order;
  final String date;
  final double totalCost;
  final User user;
  final List<List<OrderPositions>> orderPosition;
  final List<Organization> orgNames;

  OrderDetails({
    Key key,
    this.order,
    this.date,
    this.totalCost,
    this.user,
    this.orderPosition,
    this.orgNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Text(
                  order.roomNumber,
                  style: AppTextStyles.roomCardText.copyWith(fontSize: 60),
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      user.userName,
                      style: AppTextStyles.regularStyle.copyWith(fontSize: 25),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      phoneNumberChanges(user.userPhone),
                      style: AppTextStyles.regularStyle.copyWith(
                        fontSize: 20,
                        color: AppColors.lightGrey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            date,
            style: AppTextStyles.regularStyle.copyWith(
              fontSize: 22,
              color: AppColors.lightGrey,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orderPosition.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return OrderPositionsListView(
                  order: orderPosition[index],
                  organization: orgNames[index],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grayWithOpacity40,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 2),
            height: 25,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 0,
                  child: Text(
                    '${totalCost.toInt()} р',
                    style: AppTextStyles.regularStyle.copyWith(fontSize: 22),
                  ),
                ),
                Positioned(
                  right: 110,
                  child: Text(
                    'Итого',
                    style: AppTextStyles.regularStyle.copyWith(fontSize: 22),
                  ),
                ),
                Text(''),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 10,
                        color: AppColors.grayWithOpacity25,
                      ),
                    ],
                  ),
                  child: RaisedButton(
                    color: AppColors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 0,
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    onPressed: () {
                      if (order.status == 'confirmed') {
                        BlocProvider.of<OrderDetailsBloc>(context).add(ChangeOrderStatusToInWork(order: order));
                      }
                      if (order.status == 'inwork') {
                        BlocProvider.of<OrderDetailsBloc>(context).add(ChangeOrderStatusToDone(order: order));
                      }
                    },
                    child: Text(
                      order.status == 'confirmed' ? AppStrings.takeOrderInWork : AppStrings.orderCompleted,
                      style: AppTextStyles.actionButton.copyWith(fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 10,
                        color: AppColors.grayWithOpacity25,
                      ),
                    ],
                  ),
                  child: RaisedButton(
                    color: AppColors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 0,
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    onPressed: () {
                      BlocProvider.of<OrderDetailsBloc>(context).add(ChangeOrderStatusToCanceled(order: order));
                    },
                    child: Text(
                      AppStrings.cancelOrder,
                      style: AppTextStyles.actionButton.copyWith(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  String phoneNumberChanges(String phoneNumber) {
    List<String> splittedDigitsWithInsertion = phoneNumber.split('')
      ..insert(0, '+')
      ..insert(2, ' ')
      ..insert(6, ' ')
      ..insert(10, '-')
      ..insert(13, '-');
    return splittedDigitsWithInsertion.join();
  }
}
