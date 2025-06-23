// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeAdapter extends TypeAdapter<Employee> {
  @override
  final int typeId = 0;

  @override
  Employee read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Employee(
      id: fields[0] as int?,
      nom: fields[1] as String,
      prenom: fields[2] as String,
      email: fields[3] as String,
      salaire: fields[4] as double,
      poste: fields[8] as String,
      absences: fields[5] as int,
      retards: fields[6] as int,
      ponctuel: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Employee obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.prenom)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.salaire)
      ..writeByte(5)
      ..write(obj.absences)
      ..writeByte(6)
      ..write(obj.retards)
      ..writeByte(7)
      ..write(obj.ponctuel)
      ..writeByte(8)
      ..write(obj.poste);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
