import 'package:flutter/material.dart';
import 'package:servicebook/resources/resources.dart';

class OrderListHeader extends StatelessWidget {
  final String header;

  const OrderListHeader({Key key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 19),
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 15,
            color: AppColors.grayWithOpacity25,
          ),
        ],
      ),
      child: Center(
        child: Text(
          header,
          style: AppTextStyles.blueSmall.copyWith(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
