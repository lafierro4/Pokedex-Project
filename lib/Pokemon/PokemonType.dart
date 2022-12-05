
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'pokemon_type_icons_icons.dart';

part 'PokemonType.g.dart';

@HiveType(typeId: 1)
class PokemonTypes {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late Color typeColor;
  @HiveField(2)
  late int typeIcon;
  late String? typeUrl;
  late List<PokemonTypes>? weakTo; //takes double damage
  late List<PokemonTypes>? strongAgainst; //deals double damage
  late List<PokemonTypes>? immune; //takes no damage from
  PokemonTypes(this.name, this.typeColor,this.typeIcon,
      {this.typeUrl ,this.weakTo, this.strongAgainst, this.immune});

  factory PokemonTypes.fromJson(Map<String, dynamic> data) {
    final name = data['name'];
    final typeUrl = data['url'];
    final typeColor = getTypeColor(name);
    final typeIcon = getTypeIconCode(name);
    return PokemonTypes(name,typeColor,typeIcon,typeUrl: typeUrl);
  }
}


Color getTypeColor(String type) {
  switch (type) {
    case 'bug':
      return const Color.fromRGBO(168, 184, 32, 0.9);
    case 'dark':
      return const Color.fromRGBO(112, 88, 72, 0.9);
    case 'dragon':
      return const Color.fromRGBO(112, 56, 248, 0.9);
    case 'electric':
      return const Color.fromRGBO(248, 208, 48, 0.9);
    case 'fairy':
      return const Color.fromRGBO(238, 153, 172, 0.9);
    case 'fighting':
      return const Color.fromRGBO(192, 48, 40, 0.9);
    case 'fire':
      return const Color.fromRGBO(240, 128, 48, 0.9);
    case 'flying':
      return const Color.fromRGBO(168, 144, 240, 0.9);
    case 'ghost':
      return const Color.fromRGBO(112, 88, 152, 0.9);
    case 'grass':
      return const Color.fromRGBO(120, 200, 80, 0.9);
    case 'ground':
      return const Color.fromRGBO(224, 192, 104, 0.9);
    case 'ice':
      return const Color.fromRGBO(152, 216, 216, 0.9);
    case 'normal':
      return const Color.fromRGBO(168, 168, 120, 0.9);
    case 'poison':
      return const Color.fromRGBO(160, 64, 160, 0.9);
    case 'psychic':
      return const Color.fromRGBO(248, 88, 136, 0.9);
    case 'rock':
      return const Color.fromRGBO(184, 160, 56, 0.7);
    case 'steel':
      return const Color.fromRGBO(184, 184, 208, 0.7);
    case 'water':
      return const Color.fromRGBO(104, 144, 240, 0.7);
    default:
      return const Color(0xffffffff);
  }
}

int getTypeIconCode(String type) {
  switch (type) {
    case 'bug':
      return 0xe800;
    case 'dark':
      return 0xe80e;
    case 'dragon':
      return 0xe80f;
    case 'electric':
      return 0xe810;
    case 'fairy':
      return 0xe811;
    case 'fighting':
      return 0xe801;
    case 'fire':
      return 0xe802;
    case 'flying':
      return 0xe803;
    case 'ghost':
      return 0xe804;
    case 'grass':
      return 0xe805;
    case 'ground':
      return 0xe806;
    case 'ice':
      return 0xe807;
    case 'normal':
      return 0xe808;
    case 'poison':
      return 0xe809;
    case 'psychic':
      return 0xe80a;
    case 'rock':
      return 0xe80b;
    case 'steel':
      return 0xe80c;
    case 'water':
      return 0xe80d;
    default:
      return 0xe237;
  }
}



