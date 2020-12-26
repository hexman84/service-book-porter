class Settlements {
  String id;
  String userId;
  String placeId;
  String roomId;
  String createDate;
  String updateDate;
  String status;

  Settlements.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        userId = map["userid"],
        placeId = map["placeid"],
        roomId = map["roomid"],
        createDate = map["create_date"],
        updateDate = map["update_date"],
        status = map["status"];

  Settlements({
    this.id,
    this.userId,
    this.placeId,
    this.roomId,
    this.createDate,
    this.updateDate,
    this.status,
  });

  @override
  String toString() =>
      'Settlements{userId: $userId, roomId: $roomId, status: $status}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Settlements &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          placeId == other.placeId &&
          roomId == other.roomId &&
          createDate == other.createDate &&
          updateDate == other.updateDate &&
          status == other.status;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      placeId.hashCode ^
      roomId.hashCode ^
      createDate.hashCode ^
      updateDate.hashCode ^
      status.hashCode;
}
