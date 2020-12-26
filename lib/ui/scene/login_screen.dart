import 'package:flutter/material.dart';
import 'package:servicebook/resources/resources.dart';
import 'package:servicebook/ui/scene/login_form.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: LoginForm(),
      ),
    );
  }
}

