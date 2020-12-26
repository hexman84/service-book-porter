import 'package:hive/hive.dart';

part 'order_positions.g.dart';

@HiveType(typeId: 4)
class OrderPositions extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int price;
  @HiveField(3)
  final int kolvo;
  @HiveField(4)
  final String type;
  @HiveField(5)
  final String orgid;
  @HiveField(6)
  bool completed;

  OrderPositions({
    this.id,
    this.name,
    this.price,
    this.kolvo,
    this.type,
    this.orgid,
    this.completed,
  });

  OrderPositions.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'],
    price = json['price'],
    kolvo = json['kolvo'],
    type = json['type'],
    orgid = json['orgid'],
    completed = null;


  @override
  String toString() =>
      'OrderPositions{name: $name, price: $price, kolvo: $kolvo, orgid: $orgid, completed: $completed}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderPositions &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          kolvo == other.kolvo &&
          type == other.type &&
          orgid == other.orgid &&
          completed == other.completed;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      kolvo.hashCode ^
      type.hashCode ^
      orgid.hashCode ^
      completed.hashCode;
}
