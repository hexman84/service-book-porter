import 'package:flutter/material.dart';
import 'package:servicebook/resources/resources.dart';

class PreloadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              AppImages.serviceBook,
              scale: 0.9,
            ),
            SizedBox(width: 25),
            Text(
              AppStrings.ServiceBook,
              style: AppTextStyles.serviceBookText.copyWith(fontSize: 55),
            ),
          ],
        ),
      ),
    );
  }
}
