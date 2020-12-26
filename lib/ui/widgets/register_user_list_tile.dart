import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicebook/bloc/check_users/check_users_bloc.dart';
import 'package:servicebook/models/room.dart';
import 'package:servicebook/resources/resources.dart';
import 'package:servicebook/ui/widgets/login_page_text_field.dart';

class RegisterUserLine extends StatelessWidget {
  final Room room;
  final _phoneController = TextEditingController();

  RegisterUserLine({this.room});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 400,
            child: TextFieldCustom(
              hintText: AppStrings.checkInHintText,
              controller: _phoneController,
              contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              textStyle: AppTextStyles.regularStyle.copyWith(fontSize: 22),
              hintTextStyle: AppTextStyles.hintStyle.copyWith(fontSize: 22),
            ),
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
                if (_phoneController.text.isEmpty) {
                  BlocProvider.of<CheckUsersBloc>(context).add(ShowErrorEvent('Номер телефона не может быть пустым'));
                }
                if (_phoneController.text.isNotEmpty && RegExp(r'^(?:[+0])?[0-9]{11}').hasMatch(_phoneController.text)) {
                  BlocProvider.of<CheckUsersBloc>(context).add(
                    CheckInNewUser(
                      phoneNumber: _phoneController.text,
                      room: room,
                    ),
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text(
                AppStrings.checkIn,
                style: AppTextStyles.actionButton.copyWith(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
