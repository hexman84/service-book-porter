import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:servicebook/models/order.dart';
import 'package:servicebook/models/organization.dart';
import 'package:servicebook/models/room.dart';
import 'package:servicebook/models/settlements.dart';
import 'package:servicebook/models/user.dart';
import 'package:servicebook/resources/resources.dart';

class API {
  Future auth({
    @required String login,
    @required String password,
    @required String connToken,
  }) async {
    return await http.post(
      '${AppStrings.apiURL}${AppStrings.apiGetAuth}',
      body: {
        'login': login,
        'password': password,
        'conn_token': connToken,
      },
    ).then((response) {
      String token = json.decode(response.body)['token'];
      return token;
    });
  }

  Future setGoogleToken(String token, String googleToken) async {
    return await http.post(
      '${AppStrings.apiURL}${AppStrings.apiSetGoogleToken}',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: {
        'google_token': googleToken,
      },
    );
  }

  Future getPlaceData(String token) async {
    return await http.post(
      '${AppStrings.apiURL}${AppStrings.apiGetHotel}',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    ).then((response) {
      Map<String, dynamic> placeData = json.decode(response.body);
      return placeData;
    });
  }

  Future getRooms(String token, String placeId) async {
    return await http.post(
      '${AppStrings.apiURL}${AppStrings.apiGetRooms}',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: {
        'hotelId': placeId,
      },
    ).then((response) {
      List<dynamic> rooms = json.decode(response.body)['list'];
      return rooms.map((room) => Room.fromJson(room)).toList();
    });
  }

  Future getMyInfo(String token) async {
    return await http.post(
      '${AppStrings.apiURL}${AppStrings.apiGetMyInfo}',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    ).then((response) {
      String userName = json.decode(response.body)['username'];
      return userName;
    });
  }

  Future getOrders(String token, {String limit, String offset}) async {
    return await http.post(
      '${AppStrings.apiURL}${AppStrings.apiGetOrders}',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: {
        'limit': limit ?? '40',
        'offset': offset ?? '0',
      },
    ).then((response) {
      List<dynamic> orders = json.decode(response.body)['value'];
      return orders.map((order) => Order.fromJson(order)).toList();
    });
  }

  Future getSettlements(String token) async {
    return await http.post(
      '${AppStrings.apiURL}${AppStrings.apiGetSettlements}',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    ).then((response) {
      List<dynamic> settlements = json.decode(response.body)['list'];
      return settlements.map((settlement) => Settlements.fromJson(settlement)).toList();
    });
  }

  Future getUser(String token, String userId) async {
    return await http.post(
      '${AppStrings.apiURL}${AppStrings.apiGetUser}',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: {
        'id': userId,
      },
    ).then((response) {
      Map user = json.decode(response.body);
      return User.fromJson(user);
    });
  }

  Future getOrganizations(String token) async {
    return await http.post(
      '${AppStrings.apiURL}${AppStrings.apiGetOrganizations}',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    ).then((response) {
      List<dynamic> organizations = json.decode(response.body)['list'];
      return organizations.map((org) => Organization.fromJson(org)).toList();
    });
  }

  Future checkIn(String token, {String phoneNumber, String roomId}) async {
    return await http.post('${AppStrings.apiURL}${AppStrings.apiCheckIn}', headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    }, body: {
      'phone': phoneNumber,
      'roomId': roomId,
    });
  }

  Future checkOut(String token, {String phoneNumber, String roomId, String status}) async {
    return await http.post('${AppStrings.apiURL}${AppStrings.apiCheckOut}', headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    }, body: {
      'phone': phoneNumber,
      'roomId': roomId,
      'status': status,
    });
  }

  Future getRoomStatus(String token, {String roomId}) async {
    return await http.post('${AppStrings.apiURL}${AppStrings.apiGetRoomStatus}', headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    }, body: {
      'id': roomId,
    });
  }

  Future<bool> changeOrderStatus({String token, String orderId, String newStatus}) async {
    return await http.post(
      '${AppStrings.apiURL}${AppStrings.apiSetOrderStatus}',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: {
        'id': orderId,
        'status': newStatus,
      },
    ).then((response) {
      Map jsonData = json.decode(response.body);
      bool statusChanged = false;
      if (jsonData.containsKey('code')) {
        if (jsonData['code'] == 0) statusChanged = true;
      }
      return statusChanged;
    });
  }
}
