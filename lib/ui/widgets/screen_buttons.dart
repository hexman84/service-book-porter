import 'package:flutter/material.dart';
import 'package:servicebook/resources/resources.dart';
import 'package:servicebook/ui/scene/history_screen.dart';
import 'package:servicebook/ui/scene/orders_screen.dart';
import 'package:servicebook/ui/scene/rooms_screen.dart';

class ScreenButtons extends StatelessWidget {
  final bool roomsPage;
  final bool ordersPage;
  final bool historyPage;

  const ScreenButtons({
    Key key,
    this.roomsPage = false,
    this.ordersPage = false,
    this.historyPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 15,
            color: AppColors.grayWithOpacity25,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          RaisedButton(
            onPressed: roomsPage
                ? null
                : () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => RoomsPage(),
                      ),
                      (route) => false,
                    ),
            color: AppColors.white,
            elevation: 0,
            highlightElevation: 0,
            disabledColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(7),
                topLeft: Radius.circular(7),
                topRight: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Text(
                AppStrings.rooms,
                style: AppTextStyles.blueSmall,
              ),
            ),
          ),
          RaisedButton(
            onPressed: ordersPage
                ? null
                : () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => OrdersPage(),
                      ),
                      (route) => false,
                    ),
            color: AppColors.white,
            elevation: 0,
            highlightElevation: 0,
            disabledColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Text(
                AppStrings.orders,
                style: AppTextStyles.blueSmall,
              ),
            ),
          ),
          RaisedButton(
            onPressed: historyPage
                ? null
                : () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HistoryPage(),
                      ),
                      (route) => false,
                    ),
            color: AppColors.white,
            elevation: 0,
            highlightElevation: 0,
            disabledColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Text(
                AppStrings.history,
                style: AppTextStyles.blueSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
