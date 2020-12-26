// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_positions.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderPositionsAdapter extends TypeAdapter<OrderPositions> {
  @override
  OrderPositions read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderPositions(
      id: fields[0] as String,
      name: fields[1] as String,
      price: fields[2] as int,
      kolvo: fields[3] as int,
      type: fields[4] as String,
      orgid: fields[5] as String,
      completed: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, OrderPositions obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.kolvo)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.orgid)
      ..writeByte(6)
      ..write(obj.completed);
  }

  @override
  int get typeId => 4;
}
