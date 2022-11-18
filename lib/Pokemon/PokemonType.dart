
import 'package:flutter/material.dart';
import 'pokemon_type_icons_icons.dart';

class PokemonTypes {
  late String name;
  late Color typeColor;
  late IconData typeIcon;
  late String? typeUrl;
  late List<PokemonTypes>? weakTo; //takes double damage
  late List<PokemonTypes>? strongAgainst; //deals double damage
  late List<PokemonTypes>? immune; //takes no damage from
  PokemonTypes(this.name, this.typeColor,this.typeIcon,
      {this.typeUrl ,this.weakTo, this.strongAgainst, this.immune});

  factory PokemonTypes.fromJson(Map<String, dynamic> data) {
    final name = data['type']['name'];
    final typeUrl = data['type']['url'];
    final typeColor = getTypeColor(name);
    final typeIcon = getTypeIcon(name);
    return PokemonTypes(name,typeColor,typeIcon,typeUrl: typeUrl);
  }
}


Color getTypeColor(String type) {
  switch (type) {
    case 'bug':
      return const Color.fromRGBO(168, 184, 32, 0);
    case 'dark':
      return const Color.fromRGBO(112, 88, 72, 0);
    case 'dragon':
      return const Color.fromRGBO(112, 56, 248, 0);
    case 'electric':
      return const Color.fromRGBO(248, 208, 48, 0);
    case 'fairy':
      return const Color.fromRGBO(238, 153, 172, 0);
    case 'fighting':
      return const Color.fromRGBO(192, 48, 40, 0);
    case 'fire':
      return const Color.fromRGBO(240, 128, 48, 0);
    case 'flying':
      return const Color.fromRGBO(168, 144, 240, 0);
    case 'ghost':
      return const Color.fromRGBO(112, 88, 152, 0);
    case 'grass':
      return const Color.fromRGBO(120, 200, 80, 0);
    case 'ground':
      return const Color.fromRGBO(224, 192, 104, 0);
    case 'ice':
      return const Color.fromRGBO(152, 216, 216, 0);
    case 'normal':
      return const Color.fromRGBO(168, 168, 120, 0);
    case 'poison':
      return const Color.fromRGBO(160, 64, 160, 0);
    case 'psychic':
      return const Color.fromRGBO(248, 88, 136, 0);
    case 'rock':
      return const Color.fromRGBO(184, 160, 56, 0);
    case 'steel':
      return const Color.fromRGBO(184, 184, 208, 0);
    case 'water':
      return const Color.fromRGBO(104, 144, 240, 0);
    default:
      return const Color(0xffffffff);
  }
}

IconData getTypeIcon(String type) {
  switch (type) {
    case 'bug':
      return  PokemonTypeIcons.bug;
    case 'dark':
      return  PokemonTypeIcons.dark;
    case 'dragon':
      return  PokemonTypeIcons.dragon;
    case 'electric':
      return  PokemonTypeIcons.electric;
    case 'fairy':
      return  PokemonTypeIcons.fairy;
    case 'fighting':
      return  PokemonTypeIcons.fighting;
    case 'fire':
      return  PokemonTypeIcons.fire;
    case 'flying':
      return  PokemonTypeIcons.flying;
    case 'ghost':
      return  PokemonTypeIcons.ghost;
    case 'grass':
      return  PokemonTypeIcons.grass;
    case 'ground':
      return  PokemonTypeIcons.ground;
    case 'ice':
      return  PokemonTypeIcons.ice;
    case 'normal':
      return  PokemonTypeIcons.normal;
    case 'poison':
      return  PokemonTypeIcons.poison;
    case 'psychic':
      return  PokemonTypeIcons.psychic;
    case 'rock':
      return  PokemonTypeIcons.rock;
    case 'steel':
      return  PokemonTypeIcons.steel;
    case 'water':
      return  PokemonTypeIcons.water;
    default:
      return  Icons.error;
  }
}



