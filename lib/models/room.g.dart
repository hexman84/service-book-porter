// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoomAdapter extends TypeAdapter<Room> {
  @override
  Room read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Room(
      fields[1] as String,
      fields[3] as String,
      fields[4] as String,
      id: fields[0] as String,
      floor: fields[2] as int,
      roomNumber: fields[5] as String,
      status: fields[6] as String,
      roomers: (fields[7] as List)?.cast<User>(),
    );
  }

  @override
  void write(BinaryWriter writer, Room obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.corpusId)
      ..writeByte(2)
      ..write(obj.floor)
      ..writeByte(3)
      ..write(obj.hotelId)
      ..writeByte(4)
      ..write(obj.roomCategory)
      ..writeByte(5)
      ..write(obj.roomNumber)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.roomers);
  }

  @override
  int get typeId => 0;
}
