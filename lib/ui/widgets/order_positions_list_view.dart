import 'package:flutter/material.dart';
import 'package:servicebook/models/order_positions.dart';
import 'package:servicebook/models/organization.dart';
import 'package:servicebook/ui/widgets/order_details_list_item.dart';
import 'package:servicebook/ui/widgets/order_details_list_view_header.dart';

class OrderPositionsListView extends StatelessWidget {
  final List<OrderPositions> order;
  final Organization organization;
  final bool canSelectPositions;

  OrderPositionsListView({
    Key key,
    this.order,
    this.organization,
    this.canSelectPositions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        OrderListViewHeader(title: organization.name),
        ListView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: order.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return OrderItem(
              key: UniqueKey(),
              orderPosition: order[index],
              canSelect: canSelectPositions,
            );
          },
        ),
      ],
    );
  }
}
