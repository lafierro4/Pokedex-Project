import 'dart:core';
import 'PokemonType.dart';

class Pokemon {
  /// the pokemon's id
  late int id;
  /// the pokemon's name
  late String name;
  /// the pokemon's type
  late List<PokemonTypes> types;
  ///URL to the Pokemon's official artwork
  late String officialArt;
  /// the URL to the pokemon's front sprite
  late String?  frontSprite;
  /// the URL to the pokemon's back sprite
  late String? backSprite;
  late int? baseExp;
  late double? height;
  late double? weight;
  late List<String>? abilities;
  late List<String>? moves;
  late List<int>? stats;

  /// Only gets the non-nullable parameters, for testing important parts
  Pokemon.essential(this.id, this.name, this.types,this.officialArt);

  ///full parameter constructor for Pokemon
  Pokemon(this.id, this.name, this.types, this.officialArt,
      {this.frontSprite, this.backSprite, this.baseExp,
        this.height, this.weight, this.abilities, this.moves, this.stats });

  /// Pokemon Constructor to get the essential parameters from a JSON
  factory Pokemon.fromJson(Map<String, dynamic> data) {
    final id = data['id'];
    final name = data['name'];
    final officialArt = data['sprites']['other']['official-artwork']['front_default'];
    var list = [];
    for(int i = 0; i <= 1; i++) {
      try {
        var currentType = data['types'][i]['type'];
        list.add(currentType);
      }on RangeError {continue;}
    }
    List<PokemonTypes> types = list.map((i) => PokemonTypes.fromJson(i)).toList();
    return Pokemon(id,name,types, officialArt);
  }

  @override
  String toString() {
    return 'Pokemon{id: $id, name: $name, frontSprite: $frontSprite, backSprite: $backSprite, '
        'types: $types, baseExp: $baseExp, height: $height, weight: $weight, '
        'abilities: $abilities, moves: $moves, stats: $stats}';
  }
}
