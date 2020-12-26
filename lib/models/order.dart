import 'package:hive/hive.dart';
import 'package:servicebook/models/order_positions.dart';

part 'order.g.dart';

@HiveType(typeId: 3)
class Order extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String comment;
  @HiveField(2)
  String createDate;
  @HiveField(3)
  String finishDate;
  @HiveField(4)
  String releaseDate;
  @HiveField(5)
  List<OrderPositions> positions;
  @HiveField(6)
  String status;
  @HiveField(7)
  String userId;
  @HiveField(8)
  String roomNumber;
  @HiveField(9)
  int zakazKey;

  Order({
    this.id,
    this.comment,
    this.createDate,
    this.finishDate,
    this.releaseDate,
    this.positions,
    this.status,
    this.userId,
    this.roomNumber,
    this.zakazKey,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    createDate = json['create_date'];
    finishDate = json['finish_date'];
    releaseDate = json['release_date'];
    if (json['positions'] != null) {
      positions = List<OrderPositions>();
      json['positions'].forEach((v) {
        positions.add(OrderPositions.fromJson(v));
      });
    }
    status = json['status'];
    userId = json['userid'];
    roomNumber = json['roomNumber'];
    zakazKey = json['zakazkey'];
  }

  @override
  String toString() =>
      'Order{roomNumber: $roomNumber, zakazKey: $zakazKey, orderId: $id}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          comment == other.comment &&
          createDate == other.createDate &&
//          finishDate == other.finishDate &&
          releaseDate == other.releaseDate &&
          status == other.status &&
          userId == other.userId &&
          roomNumber == other.roomNumber &&
          zakazKey == other.zakazKey;

  @override
  int get hashCode =>
      id.hashCode ^
      comment.hashCode ^
      createDate.hashCode ^
//      finishDate.hashCode ^
      releaseDate.hashCode ^
      status.hashCode ^
      userId.hashCode ^
      roomNumber.hashCode ^
      zakazKey.hashCode;
}
