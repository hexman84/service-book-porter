import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicebook/bloc/auth/bloc.dart';
import 'package:servicebook/bloc/logged_user/bloc.dart';
import 'package:servicebook/bloc/order_details/bloc.dart';
import 'package:servicebook/bloc/orders/bloc.dart';
import 'package:servicebook/bloc/rooms/bloc.dart';
import 'package:servicebook/resources/images.dart';
import 'package:servicebook/ui/scene/main_screen.dart';

class LogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false,
        );
        BlocProvider.of<LoggedUserBloc>(context).add(DeleteUser());
        BlocProvider.of<RoomsBloc>(context).add(DeleteRoomsData());
        BlocProvider.of<OrdersBloc>(context).add(DeleteOrdersData());
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
        BlocProvider.of<OrderDetailsBloc>(context).add(RemoveOrderFromState());
      },
      child: Image.asset(
        AppImages.logOut,
        scale: 3.5,
      ),
    );
  }
}
