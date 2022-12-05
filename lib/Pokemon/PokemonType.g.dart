// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PokemonType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonTypesAdapter extends TypeAdapter<PokemonTypes> {
  @override
  final int typeId = 1;

  @override
  PokemonTypes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonTypes(
      fields[0] as String,
      fields[1] as Color,
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonTypes obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.typeColor)
      ..writeByte(2)
      ..write(obj.typeIcon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
