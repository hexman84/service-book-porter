import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicebook/bloc/order_details/bloc.dart';
import 'package:servicebook/models/order_positions.dart';
import 'package:servicebook/resources/resources.dart';

class OrderItem extends StatefulWidget {
  final OrderPositions orderPosition;
  final bool canSelect;

  OrderItem({
    Key key,
    this.orderPosition,
    this.canSelect = true,
  }) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  List<bool> buttonsSelected;

  @override
  void initState() {
    if (widget.orderPosition.completed != null) {
      if (widget.orderPosition.completed) {
        buttonsSelected = [true, false];
      } else {
        buttonsSelected = [false, true];
      }
    } else {
      buttonsSelected = [false, false];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Text(
              widget.orderPosition.name,
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: AppTextStyles.regularStyle.copyWith(fontSize: 22),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${widget.orderPosition.kolvo} шт',
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.regularStyle.copyWith(fontSize: 22),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '${widget.orderPosition.price} р',
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.regularStyle.copyWith(fontSize: 22),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: ToggleButtons(
                children: <Widget>[
                  Icon(Icons.check),
                  Icon(Icons.clear),
                ],
                isSelected: buttonsSelected,
                onPressed: widget.canSelect
                    ? (index) {
                        for (int btnIndex = 0; btnIndex < buttonsSelected.length; btnIndex++) {
                          if (btnIndex == index) {
                            buttonsSelected[btnIndex] = true;
                          } else {
                            buttonsSelected[btnIndex] = false;
                          }
                        }
                        BlocProvider.of<OrderDetailsBloc>(context)
                          ..add(ModifyOrderPositionStatus(
                            orderPositionId: widget.orderPosition.id,
                            status: index == 0 ? true : false,
                          ));
                        setState(() {});
                      }
                    : (_) {},
                borderRadius: BorderRadius.circular(7),
                constraints: BoxConstraints(
                  minHeight: 32,
                  minWidth: 32,
                ),
                color: AppColors.darkGrey,
                selectedColor: buttonsSelected[0] ? AppColors.green : AppColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
