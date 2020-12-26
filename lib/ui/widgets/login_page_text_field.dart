import 'package:flutter/material.dart';
import 'package:servicebook/resources/resources.dart';

class TextFieldCustom extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final EdgeInsets contentPadding;
  final TextStyle textStyle;
  final TextStyle hintTextStyle;

  const TextFieldCustom({
    Key key,
    @required this.hintText,
    @required this.controller,
    @required this.textStyle,
    @required this.hintTextStyle,
    this.obscureText = false,
    this.contentPadding,
  })  : assert(hintText != null),
        assert(controller != null),
        assert(textStyle != null),
        assert(hintTextStyle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 15,
            color: AppColors.grayWithOpacity25,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: textStyle,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(7),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide:
                BorderSide(width: 1, color: AppColors.grayWithOpacity40),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(width: 1, color: AppColors.red),
          ),
          contentPadding:
              contentPadding ?? EdgeInsets.symmetric(vertical: 15, horizontal: 23),
          hintText: hintText,
          hintStyle: hintTextStyle,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
