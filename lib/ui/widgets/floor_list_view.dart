import 'package:flutter/material.dart';
import 'package:servicebook/models/room.dart';
import 'package:servicebook/ui/widgets/room_card.dart';

class FloorListView extends StatelessWidget {
  final List<Room> rooms;

  FloorListView({Key key, this.rooms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    return Container(
      height: sizeWidth * .17 - sizeWidth * .025 * 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: rooms.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return RoomCard(room: rooms[index]);
        },
      ),
    );
  }
}
