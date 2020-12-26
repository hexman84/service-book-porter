import 'package:flutter/material.dart';
import 'package:servicebook/resources/resources.dart';

class OrderListViewHeader extends StatelessWidget {
  final String title;

  const OrderListViewHeader({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grayWithOpacity40,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        Text(
          title,
          style: AppTextStyles.regularStyle.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Flexible(
          flex: 8,
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grayWithOpacity40,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}
