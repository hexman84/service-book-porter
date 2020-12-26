import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:servicebook/bloc/rooms/bloc.dart';
import 'package:servicebook/models/room.dart';
import 'package:servicebook/models/user.dart';
import 'package:servicebook/network/api.dart';

part 'check_users_event.dart';
part 'check_users_state.dart';

class CheckUsersBloc extends Bloc<CheckUsersEvent, CheckUsersState> {
  final API _api = API();
  final RoomsBloc roomsBloc;

  CheckUsersBloc({@required this.roomsBloc}) : assert(roomsBloc != null);

  @override
  Stream<CheckUsersState> mapEventToState(
    CheckUsersEvent event,
  ) async* {
    if (event is AddCheckInUserData) {
      yield* _mapPushToState(event);
    }
    if (event is CheckInNewUser) {
      yield* _mapCheckInToState(event);
    }
    if (event is CheckOutUser) {
      yield* _mapCheckOutToState(event);
    }
    if (event is ShowErrorEvent) {
      yield LoadingCheckUser();
      yield ShowError(error: event.error);
    }
  }

  Stream<CheckUsersState> _mapCheckInToState(CheckInNewUser event) async* {
    yield LoadingCheckUser();
    Room currRoom = event.room;
    String phoneNumber = event.phoneNumber;
    if (RegExp(r'^(?:[+0])?[0-9]{11}').hasMatch(phoneNumber)) {
      final token = Hive.box('importantData').get('token');
      _api.checkIn(token, phoneNumber: phoneNumber, roomId: currRoom.id).then(
            (response) async* {
          var resCode = json.decode(response.body)['code'];
          switch (resCode) {
            case '1004' : {
              yield ShowError(error: 'Неправильные параметры');
              break;
            }
            case '1008' : {
              yield ShowError(error: 'Пользователь проживает в другой комнате');
              break;
            }
          }
        },
      );
    } else {
      yield ShowError(error: 'Неверный формат телефона');
    }
  }


  Stream<CheckUsersState> _mapCheckOutToState(CheckOutUser event) async* {
    yield LoadingCheckUser();
    String currRoomId = event.roomId;
    User currUser = event.user;
    final token = Hive.box('importantData').get('token');
    bool status = false;
    final roomsBox = Hive.box<Room>('rooms');
    try {
      await _api
          .checkOut(
        token,
        phoneNumber: currUser.userPhone,
        roomId: currRoomId,
        status: 'completed',
      )
          .then(
            (response) async {
          Map<String, dynamic> res = json.decode(response.body);
          print('$res - статус выселения');
          if (res['code'] == 0) {
            status = true;
            Room currRoom =
            roomsBox.values.firstWhere((room) => room.id == currRoomId);
            currRoom.roomers.remove(currUser);
            await _api.getRoomStatus(token, roomId: currRoom.id).then((resp) {
              Map<String, dynamic> answer = json.decode(resp.body);
              print(answer);
              if (currRoom.roomers.length == 0) {
                print('change room status ${currRoom.status} - ${answer['status']}');
                currRoom.status = 'free'; //TODO answer['status']
              }
            });
            currRoom.save();
          }
        },
      );
    } catch (e) {
      yield ShowError(error: e);
    }
    if (status) {
      roomsBloc.add(ReshowRoomsData());
    }
  }

  Stream<CheckUsersState> _mapPushToState(AddCheckInUserData event) async* {
    final userBox = Hive.box<User>('allUsers');
    final token = Hive.box('importantData').get('token');
    final roomsBox = Hive.box<Room>('rooms');
    String currUserId = event.userId;
    String currRoomId = event.roomId;
    Room currRoom = roomsBox.values.firstWhere((room) => room.id == currRoomId);
    User currUser = await _api.getUser(token, currUserId);
    await _api.getRoomStatus(token, roomId: currRoom.id).then((resp) {
      Map<String, dynamic> answer = json.decode(resp.body);
      print('change room status ${currRoom.status} - ${answer['status']}');
      currRoom.status = 'busy'; //TODO answer['status']
    });
    currRoom.roomers.add(currUser);
    currRoom.save();
    if (!userBox.values.contains(currUser)) {
      userBox.add(currUser);
    }
    roomsBloc.add(ReshowRoomsData());
  }

  @override
  CheckUsersState get initialState => CheckUsersInitial();
}
