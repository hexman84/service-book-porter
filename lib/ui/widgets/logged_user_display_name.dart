import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicebook/bloc/logged_user/bloc.dart';
import 'package:servicebook/resources/resources.dart';

class LoggedUserName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        BlocBuilder<LoggedUserBloc, LoggedUserState>(
          builder: (context, state) {
            if (state is LoggedUserLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoggedUserLoaded) {
              return Text(
                state.userName,
                style: AppTextStyles.blueSmall,
              );
            }
            if (state is LoggedUserFailure) {
              return Text('Error');
            }
            return Container();
          },
        ),
        SizedBox(width: 15),
        Image.asset(
          AppImages.user,
          scale: 3.5,
        ),
      ],
    );
  }
}
