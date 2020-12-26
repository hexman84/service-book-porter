import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicebook/bloc/check_users/check_users_bloc.dart';
import 'package:servicebook/models/user.dart';
import 'package:servicebook/resources/resources.dart';

class UserListTile extends StatelessWidget {
  final User user;
  final String roomId;

  UserListTile({Key key, this.user, this.roomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            user.userName,
            style: AppTextStyles.regularStyle,
          ),
          Container(
            width: 150,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 6),
                  blurRadius: 15,
                  color: AppColors.grayWithOpacity25,
                ),
              ],
            ),
            child: RaisedButton(
              color: AppColors.blue,
              padding: const EdgeInsets.symmetric(vertical: 7),
              elevation: 0,
              highlightElevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              onPressed: () {
                BlocProvider.of<CheckUsersBloc>(context)
                    .add(CheckOutUser(roomId: roomId, user: user));
                Navigator.of(context).pop();
              },
              child: Text(
                AppStrings.checkOut,
                style: AppTextStyles.actionButton.copyWith(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
