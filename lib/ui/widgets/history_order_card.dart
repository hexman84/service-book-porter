import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicebook/bloc/history_order_details/history_order_details_bloc.dart';
import 'package:servicebook/models/order.dart';
import 'package:servicebook/resources/resources.dart';

class HistoryOrderCard extends StatefulWidget {
  final Order order;

  const HistoryOrderCard({Key key, this.order}) : super(key: key);

  @override
  _HistoryOrderCardState createState() => _HistoryOrderCardState();
}

class _HistoryOrderCardState extends State<HistoryOrderCard> {
  bool selectedToShow = false;

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    BlocProvider.of<HistoryOrderDetailsBloc>(context).listen((value) {
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
      onTap: () => BlocProvider.of<HistoryOrderDetailsBloc>(context).add(
        AddHistoryOrderDetailsToDisplay(zakazKey: widget.order.zakazKey),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 19),
            width: double.infinity,
            height: 116,
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
                    color: AppColors.darkGrey,
                  ),
                ),
                Text(
                  '#${widget.order.zakazKey}',
                  style: AppTextStyles.roomCardText.copyWith(
                    fontSize: sizeHeight * .03,
                    color: AppColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 10,
            child: Container(
              width: 150,
              height: 84,
              alignment: Alignment.centerRight,
              child: Text(
                '${showStatus()}',
                style: AppTextStyles.regularStyle.copyWith(fontSize: sizeHeight * .04),
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String showStatus() {
    String status = widget.order.status;
    String res;
    switch (status) {
      case 'annulled':
        res = 'отменён';
        break;
      case 'done':
        res = 'выполнен';
        break;
      case 'partially':
        res = 'частично выполнен';
        break;
    }
    return res;
  }
}
