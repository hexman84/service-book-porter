import 'package:flutter/material.dart';
import 'package:servicebook/models/room.dart';
import 'package:servicebook/resources/resources.dart';
import 'package:servicebook/ui/widgets/modal_room_window.dart';

class RoomCard extends StatelessWidget {
  final Room room;

  RoomCard({Key key, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final checkStatus = room.status == 'free';
    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return ModalRoomWindow(room: room);
          },
        );
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: sizeWidth * .17,
          decoration: BoxDecoration(
            color: checkStatus ? AppColors.white : AppColors.green,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 6),
                color: AppColors.grayWithOpacity25,
                blurRadius: 15,
              ),
            ],
          ),
          margin: EdgeInsets.all(sizeWidth * .015),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  AppImages.logoBed,
                  scale: 3.5,
                  color: checkStatus ? null : AppColors.white,
                ),
                Text(
                  room.roomNumber,
                  style: AppTextStyles.roomCardText.copyWith(
                    color: checkStatus ? null : AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
