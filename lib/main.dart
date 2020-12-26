import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:servicebook/bloc/auth/bloc.dart';
import 'package:servicebook/bloc/bloc_delegate.dart';
import 'package:servicebook/bloc/history_order_details/history_order_details_bloc.dart';
import 'package:servicebook/bloc/logged_user/bloc.dart';
import 'package:servicebook/bloc/login/bloc.dart';
import 'package:servicebook/bloc/order_details/bloc.dart';
import 'package:servicebook/bloc/orders/bloc.dart';
import 'package:servicebook/bloc/rooms/bloc.dart';
import 'package:servicebook/models/order.dart';
import 'package:servicebook/models/order_positions.dart';
import 'package:servicebook/models/organization.dart';
import 'package:servicebook/models/room.dart';
import 'package:servicebook/models/user.dart';
import 'package:servicebook/ui/scene/main_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'bloc/check_users/check_users_bloc.dart';
import 'network/fcm_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  // adapters
  Hive.registerAdapter(RoomAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(OrderPositionsAdapter());
  Hive.registerAdapter(OrganizationAdapter());
  // Hive boxes
  await Hive.openBox('importantData');
  await Hive.openBox<Room>('rooms');
  await Hive.openBox<Order>('activeOrders');
  await Hive.openBox<Order>('ordersHistory');
  await Hive.openBox<User>('allUsers');
  await Hive.openBox<Organization>('organizations');

  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc()..add(AppStarted()),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          ),
        ),
        BlocProvider<RoomsBloc>(
          create: (context) => RoomsBloc(),
        ),
        BlocProvider<CheckUsersBloc>(
          create: (context) => CheckUsersBloc(roomsBloc: BlocProvider.of<RoomsBloc>(context)),
        ),
        BlocProvider<LoggedUserBloc>(
          create: (context) => LoggedUserBloc(),
        ),
        BlocProvider<OrdersBloc>(
          create: (context) => OrdersBloc(),
        ),
        BlocProvider<OrderDetailsBloc>(
          create: (context) => OrderDetailsBloc(
            ordersBloc: BlocProvider.of<OrdersBloc>(context),
          ),
        ),
        BlocProvider<HistoryOrderDetailsBloc>(
          create: (context) => HistoryOrderDetailsBloc(),
        ),
      ],
      child: AppPushNotifications(child: MainScreen()),
    ),
  );
}
