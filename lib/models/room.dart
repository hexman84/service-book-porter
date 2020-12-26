import 'package:hive/hive.dart';
import 'package:servicebook/models/user.dart';

part 'room.g.dart';

@HiveType(typeId: 0)
class Room extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String corpusId;
  @HiveField(2)
  final int floor;
  @HiveField(3)
  final String hotelId;
  @HiveField(4)
  final String roomCategory;
  @HiveField(5)
  final String roomNumber;
  @HiveField(6)
  String status;
  @HiveField(7)
  final List<User> roomers;

  Room.fromJson(Map json)
      : this.id = json['id'],
        this.corpusId = json['corpusId'],
        this.floor = json['floor'],
        this.hotelId = json['hotelId'],
        this.roomCategory = json['roomCategory'],
        this.roomNumber = json['roomNumber'],
        this.status = json['status'],
        this.roomers = [];

  Room(
    this.corpusId,
    this.hotelId,
    this.roomCategory, {
    this.id,
    this.floor,
    this.roomNumber,
    this.status,
    this.roomers,
  });

  @override
  String toString() =>
      'Room{roomNumber: $roomNumber, status: $status, roomers: $roomers}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Room &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          corpusId == other.corpusId &&
          floor == other.floor &&
          hotelId == other.hotelId &&
          roomCategory == other.roomCategory &&
          roomNumber == other.roomNumber &&
          status == other.status &&
          roomers == other.roomers;

  @override
  int get hashCode =>
      id.hashCode ^
      corpusId.hashCode ^
      floor.hashCode ^
      hotelId.hashCode ^
      roomCategory.hashCode ^
      roomNumber.hashCode ^
      status.hashCode ^
      roomers.hashCode;
}
