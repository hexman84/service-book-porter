import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicebook/bloc/login/bloc.dart';
import 'package:servicebook/resources/resources.dart';
import 'package:servicebook/ui/widgets/login_page_text_field.dart';
import 'package:servicebook/ui/widgets/service_book_app_bar.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool connTokenOpacity = false;
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _connTokenController = TextEditingController();

  _onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(
      LoginButtonPressed(
        login: _loginController.text,
        password: _passwordController.text,
        connToken: _connTokenController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      builder: (context, state) => Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 31,
                          horizontal: 41,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 80),
                              child: ServiceBookLogo(),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 66,
                                  width: 66,
                                  child: RaisedButton(
                                    onPressed: () {
                                      setState(() {
                                        connTokenOpacity = !connTokenOpacity;
                                      });
                                    },
                                    color: connTokenOpacity
                                        ? AppColors.lightBlue
                                        : AppColors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    padding: EdgeInsets.all(11),
                                    child: Image.asset(
                                      AppImages.settings,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Opacity(
                                  opacity: connTokenOpacity ? 1.0 : 0.0,
                                  child: Container(
                                    width: 350,
                                    child: TextFieldCustom(
                                      hintText: 'ID: 517855447865',
                                      controller: _connTokenController,
                                      textStyle: AppTextStyles.regularStyle,
                                      hintTextStyle: AppTextStyles.hintStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              AppStrings.auth,
                              style: AppTextStyles.bigBold,
                            ),
                            SizedBox(height: 20),
                            Text(
                              AppStrings.login,
                              style: AppTextStyles.regularStyle,
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: 496,
                              child: TextFieldCustom(
                                hintText: AppStrings.login,
                                controller: _loginController,
                                textStyle: AppTextStyles.regularStyle,
                                hintTextStyle: AppTextStyles.hintStyle,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              AppStrings.password,
                              style: AppTextStyles.regularStyle,
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: 496,
                              child: TextFieldCustom(
                                hintText: AppStrings.password,
                                controller: _passwordController,
                                obscureText: true,
                                textStyle: AppTextStyles.regularStyle,
                                hintTextStyle: AppTextStyles.hintStyle,
                              ),
                            ),
                            SizedBox(height: 37),
                            Flexible(
                              child: Container(
                                width: 496,
                                height: 70,
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
                                  onPressed: state is LoginLoading
                                      ? null
                                      : _onLoginButtonPressed,
                                  color: AppColors.blue,
                                  elevation: 0,
                                  highlightElevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: state is LoginLoading
                                      ? CircularProgressIndicator()
                                      : Text(
                                          AppStrings.loginBtn,
                                          style: AppTextStyles.actionButton,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
