import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:servicebook/bloc/check_users/check_users_bloc.dart';
import 'package:servicebook/bloc/orders/bloc.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  // когда приложение свёрнуто прилетит сюда пушка
  print('AppPushNotifications myBackgroundMessageHandler : $message');
  if (message['data']['body'] == 'Успешное заселение клиента') {
    print('успешное заселение');
  }
  return Future<void>.value();
}

class AppPushNotifications extends StatefulWidget {
  final Widget child;

  AppPushNotifications({@required this.child});

  @override
  _AppPushNotificationsState createState() => _AppPushNotificationsState();
}

class _AppPushNotificationsState extends State<AppPushNotifications> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _initFirebaseMessaging();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  _initFirebaseMessaging() {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('AppPushNotifications onMessage : $message');
        print(message['data']);
        if (message['data']['body'] == 'Успешное заселение клиента') {
          print('успешное заселение');
          BlocProvider.of<CheckUsersBloc>(context).add(AddCheckInUserData(
            roomId: message['data']['roomid'],
            userId: message['data']['userid'],
          ));
        }
        if (message['data']['body'] == 'Откройте список заказов') {
          BlocProvider.of<OrdersBloc>(context).add(FetchOrdersData(hideLoading: true));
        }
        return;
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) {
        print('AppPushNotifications onResume : $message');
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        print('AppPushNotifications onLaunch : $message');
        return;
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    firebaseMessaging.getToken().then((googleToken) {
      final box = Hive.box('importantData');
      box.put('googleToken', googleToken);
    });
  }
}
