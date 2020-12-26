import 'package:flutter/material.dart';
import 'package:servicebook/models/room.dart';
import 'package:servicebook/resources/resources.dart';
import 'package:servicebook/ui/widgets/register_user_list_tile.dart';
import 'package:servicebook/ui/widgets/user_list_tile.dart';

class ModalRoomWindow extends StatelessWidget {
  final Room room;

  ModalRoomWindow({Key key, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenInfo = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            minWidth: constraints.maxWidth,
          ),
          child: Dialog(
            // вынести в отдельный виджет
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            child: Container(
              width: screenInfo.width * 0.6,
              height: screenInfo.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${room.roomNumber}',
                            style: AppTextStyles.roomCardText
                                .copyWith(fontSize: 30),
                          ),
                          Text(
                            AppStrings.registerModalWindow,
                            style: AppTextStyles.blueSmall
                                .copyWith(fontSize: 30),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.clear,
                              size: 35,
                              color: AppColors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: AppColors.grayWithOpacity10,
                    ),
                    Flexible(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        itemCount: room.roomers.length + 1,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          // extra index for register line
                          if (index == room.roomers.length) {
                            return RegisterUserLine(room: room);
                          }
                          return UserListTile(
                            user: room.roomers[index],
                            roomId: room.id,
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 25),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 6),
                            blurRadius: 15,
                            color: AppColors.grayWithOpacity25,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
