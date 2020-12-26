// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderAdapter extends TypeAdapter<Order> {
  @override
  Order read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      id: fields[0] as String,
      comment: fields[1] as String,
      createDate: fields[2] as String,
      finishDate: fields[3] as String,
      releaseDate: fields[4] as String,
      positions: (fields[5] as List)?.cast<OrderPositions>(),
      status: fields[6] as String,
      userId: fields[7] as String,
      roomNumber: fields[8] as String,
      zakazKey: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.comment)
      ..writeByte(2)
      ..write(obj.createDate)
      ..writeByte(3)
      ..write(obj.finishDate)
      ..writeByte(4)
      ..write(obj.releaseDate)
      ..writeByte(5)
      ..write(obj.positions)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.userId)
      ..writeByte(8)
      ..write(obj.roomNumber)
      ..writeByte(9)
      ..write(obj.zakazKey);
  }

  @override
  int get typeId => 3;
}
