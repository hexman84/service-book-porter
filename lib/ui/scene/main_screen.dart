import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:servicebook/bloc/auth/bloc.dart';
import 'package:servicebook/bloc/logged_user/bloc.dart';
import 'package:servicebook/bloc/orders/bloc.dart';
import 'package:servicebook/bloc/rooms/bloc.dart';
import 'package:servicebook/ui/scene/login_screen.dart';
import 'package:servicebook/ui/scene/preload_screen.dart';
import 'package:servicebook/ui/scene/rooms_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ServiceBook',
      home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            BlocProvider.of<RoomsBloc>(context).add(FetchRoomsData());
            BlocProvider.of<LoggedUserBloc>(context).add(UploadUser());
            BlocProvider.of<OrdersBloc>(context).add(FetchOrdersData());
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => RoomsPage()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is Uninitialized) {
            return PreloadScreen();
          }
          if (state is Unauthenticated) {
            return LoginScreen();
          }
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
