import 'package:flutter/material.dart';
import 'package:servicebook/resources/images.dart';
import 'package:servicebook/resources/resources.dart';

class ServiceBookLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(AppImages.serviceBook, scale: 1.5,),
        SizedBox(width: 15),
        Text(
          AppStrings.ServiceBook,
          style: AppTextStyles.serviceBookText.copyWith(fontSize: 35),
        ),
      ],
    );
  }
}
