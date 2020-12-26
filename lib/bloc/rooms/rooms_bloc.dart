import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:servicebook/models/room.dart';
import 'package:servicebook/models/settlements.dart';
import 'package:servicebook/models/user.dart';
import 'package:servicebook/network/api.dart';
import './bloc.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  final API _api = API();

  @override
  RoomsState get initialState => RoomsEmpty();

  @override
  Stream<RoomsState> mapEventToState(
    RoomsEvent event,
  ) async* {
    if (event is FetchRoomsData) {
      yield* _mapRoomsLoadedToState();
    }
    if (event is DeleteRoomsData) {
      yield RoomsEmpty();
    }
    if (event is ReshowRoomsData) {
      final roomsBox = Hive.box<Room>('rooms');
      yield RoomsEmpty();
      yield RoomsLoaded(rooms: _splitRoomsOnFloors(roomsBox.values.toList()));
    }
  }

  Stream<RoomsState> _mapRoomsLoadedToState() async* {
    yield RoomsLoading();
    try {
      final importantBox = Hive.box('importantData');
      final roomsBox = Hive.box<Room>('rooms');
      final userBox = Hive.box<User>('allUsers');
      final token = importantBox.get('token');
      Map<String, dynamic> placeId = await _api.getPlaceData(token);
      importantBox
        ..put('create_time', placeId['create_time'])
        ..put('ready_time', placeId['ready_time']);
      List<Room> rooms = await _api.getRooms(token, placeId['placeid']);
      List<Settlements> settlements = await _api.getSettlements(token);
      await roomsBox.clear();
      for (int i = 0; i < rooms.length; i++) {
        for (int j = 0; j < settlements.length; j++) {
          if (settlements[j].roomId == rooms[i].id) {
            User user = await _api.getUser(token, settlements[j].userId);
            rooms[i].roomers.add(user);
            if (!userBox.values.contains(user)) {
              userBox.add(user);
            }
          }
        }
      }
      roomsBox.addAll(rooms);
      yield RoomsLoaded(rooms: _splitRoomsOnFloors(roomsBox.values.toList()));
    } catch (_) {
      yield RoomsFailure();
    }
  }

  _splitRoomsOnFloors(List<Room> currentRooms) {
    List<List<Room>> splittedRoomList = [];
    int maxFloorNumber = 0;
    for (int i = 0; i < currentRooms.length; i++) {
      if (currentRooms[i].floor > maxFloorNumber)
        maxFloorNumber = currentRooms[i].floor;
    }
    for (int currentFloorNum = 1;
        currentFloorNum < maxFloorNumber + 1;
        currentFloorNum++) {
      List<Room> currentFloorList = [];
      for (int currentRoom = 0;
          currentRoom < currentRooms.length;
          currentRoom++) {
        if (currentRooms[currentRoom].floor == currentFloorNum)
          currentFloorList.add(currentRooms[currentRoom]);
      }
      splittedRoomList.add(currentFloorList);
    }
    return splittedRoomList;
  }
}
