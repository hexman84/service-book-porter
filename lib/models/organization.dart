import 'package:hive/hive.dart';

part 'organization.g.dart';

@HiveType(typeId: 5)
class Organization extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String hotelId;
  @HiveField(2)
  final String type;
  @HiveField(3)
  final String name;

  Organization({this.id, this.hotelId, this.type, this.name});

  Organization.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        hotelId = json["hotel_id"],
        type = json["type"],
        name = json["name"];

  @override
  String toString() =>
      'Organization{id: $id, hotelId: $hotelId, type: $type, name: $name}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Organization &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hotelId == other.hotelId &&
          type == other.type &&
          name == other.name;

  @override
  int get hashCode =>
      id.hashCode ^ hotelId.hashCode ^ type.hashCode ^ name.hashCode;
}
