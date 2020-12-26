import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicebook/bloc/order_details/bloc.dart';
import 'package:servicebook/models/order.dart';
import 'package:servicebook/resources/resources.dart';

class InWorkOrderCard extends StatefulWidget {
  final Order order;
  final int readyTime;

  InWorkOrderCard({Key key, this.order, this.readyTime}) : super(key: key);

  @override
  _InWorkOrderCardState createState() => _InWorkOrderCardState();
}

class _InWorkOrderCardState extends State<InWorkOrderCard> {
  Timer timer;
  bool isOrderExpired;
  bool selectedToShow = false;

  @override
  void initState() {
    isOrderExpired = checkOrderDeadline(widget.order.releaseDate);
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
              color: isOrderExpired ? AppColors.red : AppColors.green,
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
                    color: AppColors.white,
                  ),
                ),
                Text(
                  '#${widget.order.zakazKey}',
                  style: AppTextStyles.roomCardText.copyWith(
                    fontSize: sizeHeight * .03,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 37,
            right: 13,
            child: Text(
              showCurrentDifferenceInTime(widget.order.releaseDate),
              style: AppTextStyles.regularStyle.copyWith(
                fontSize: sizeHeight * .04,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool checkOrderDeadline(String releaseDate) {
    Duration res = DateTime.parse(releaseDate).add(Duration(hours: 3)).difference(DateTime.now());
    if (res.inMinutes.abs() >= widget.readyTime) return true;
    return false;
  }

  showCurrentDifferenceInTime(String releaseDate) {
    Duration res = DateTime.parse(releaseDate).add(Duration(hours: 3)).difference(DateTime.now());
    int hours = res.inHours.abs();
    int minutes = (res.inMinutes + 60 * hours).abs();
    return '$hours:${minutes.toString().padLeft(2, '0')} мин';
  }
}
