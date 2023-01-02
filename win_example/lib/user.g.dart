// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      email: fields[0] as String,
      password: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PatientAdapter extends TypeAdapter<Patient> {
  @override
  final int typeId = 45;

  @override
  Patient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Patient(
      first: fields[9] as String,
      middle: fields[10] as String,
      last: fields[11] as String,
      dob: fields[12] as String,
      gender: fields[13] as String,
      phone: fields[14] as int,
      uidai: fields[15] as int,
      height: fields[16] as int,
      weight: fields[17] as int,
      email: fields[18] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Patient obj) {
    writer
      ..writeByte(10)
      ..writeByte(9)
      ..write(obj.first)
      ..writeByte(10)
      ..write(obj.middle)
      ..writeByte(11)
      ..write(obj.last)
      ..writeByte(12)
      ..write(obj.dob)
      ..writeByte(13)
      ..write(obj.gender)
      ..writeByte(14)
      ..write(obj.phone)
      ..writeByte(15)
      ..write(obj.uidai)
      ..writeByte(16)
      ..write(obj.height)
      ..writeByte(17)
      ..write(obj.weight)
      ..writeByte(18)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecordAdapter extends TypeAdapter<Record> {
  @override
  final int typeId = 20;

  @override
  Record read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Record(
      patientNumbers: fields[20] as int,
      userNumbers: fields[21] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Record obj) {
    writer
      ..writeByte(2)
      ..writeByte(20)
      ..write(obj.patientNumbers)
      ..writeByte(21)
      ..write(obj.userNumbers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
