import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicebook/bloc/order_details/bloc.dart';
import 'package:servicebook/models/order.dart';
import 'package:servicebook/resources/resources.dart';

class NewOrderCard extends StatefulWidget {
  final Order order;
  final int createTime;

  NewOrderCard({Key key, this.order, this.createTime}) : super(key: key);

  @override
  _NewOrderCardState createState() => _NewOrderCardState();
}

class _NewOrderCardState extends State<NewOrderCard> {
  Timer timer;
  bool isOrderExpired;
  bool selectedToShow = false;

  @override
  void initState() {
    isOrderExpired = checkOrderDeadline(widget.order.createDate);
    timer = Timer.periodic(Duration(minutes: 1), (timer) {
      if (timer.isActive) {
        setState(() {
          isOrderExpired = checkOrderDeadline(widget.order.createDate);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    BlocProvider.of<OrderDetailsBloc>(context).listen((value) {
      if (value.props.isNotEmpty && this.mounted) {
        Order order = value.props[0];
        if (order.id == widget.order.id) {
          selectedToShow = true;
        } else {
          selectedToShow = false;
        }
        setState(() {});
      }
    });
    return GestureDetector(
      onTap: () =>
          BlocProvider.of<OrderDetailsBloc>(context).add(AddOrderDetailsToDisplay(zakazKey: widget.order.zakazKey)),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 19),
            width: double.infinity,
            height: 116,
            decoration: BoxDecoration(
              color: isOrderExpired ? AppColors.red : AppColors.white,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 6),
                  blurRadius: 15,
                  color: AppColors.grayWithOpacity25,
                ),
              ],
              border: Border.all(
                width: 2,
                color: selectedToShow ? AppColors.darkGrey : Colors.transparent,
              ),
            ),
          ),
          Positioned(
            top: 18,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  AppImages.logoBed,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Positioned(
            left: 91,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.order.roomNumber,
                  style: AppTextStyles.roomCardText.copyWith(
                    fontSize: sizeHeight * .055,
                    color: isOrderExpired ? AppColors.white : AppColors.darkGrey,
                  ),
                ),
                Text(
                  '#${widget.order.zakazKey}',
                  style: AppTextStyles.roomCardText.copyWith(
                    fontSize: sizeHeight * .03,
                    color: isOrderExpired ? AppColors.white : AppColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 42,
            right: 13,
            child: Text(
              showCurrentDifferenceInTime(widget.order.createDate),
              style: AppTextStyles.regularStyle.copyWith(
                color: isOrderExpired ? AppColors.white : AppColors.darkGrey, fontSize: sizeHeight * .04,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool checkOrderDeadline(String createDate) {
    Duration res = DateTime.now().difference(DateTime.parse(createDate).add(Duration(hours: 3)));
    if (res.inMinutes >= widget.createTime) return true;
    return false;
  }

  showCurrentDifferenceInTime(String createDate) {
    Duration res = DateTime.now().difference(DateTime.parse(createDate).add(Duration(hours: 3)));
    int hours = res.inHours;
    int minutes = res.inMinutes - 60 * hours;
    return '$hours:${minutes.toString().padLeft(2, '0')} мин';
  }
}
