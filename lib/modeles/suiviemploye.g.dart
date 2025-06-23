// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suiviemploye.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SuiviEmployeAdapter extends TypeAdapter<SuiviEmploye> {
  @override
  final int typeId = 2;

  @override
  SuiviEmploye read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SuiviEmploye(
      nom: fields[0] as String,
      matricule: fields[1] as String,
      absences: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SuiviEmploye obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nom)
      ..writeByte(1)
      ..write(obj.matricule)
      ..writeByte(2)
      ..write(obj.absences);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuiviEmployeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
