import 'dart:core';
import 'package:hive_flutter/adapters.dart';
import 'PokemonType.dart';
import 'package:hive/hive.dart';
part 'PokemonModel.g.dart';

@HiveType(typeId: 0)
class Pokemon{
  /// the pokemon's id
  @HiveField(0)
  late int id;
  /// the pokemon's name
  @HiveField(1)
  late String name;
  /// the pokemon's type
  @HiveField(2)
  late List<PokemonTypes> types;
  ///URL to the Pokemon's official artwork
  @HiveField(3)
  late String officialArt;
  @HiveField(4)
  late int? baseExp;
  @HiveField(5)
  late int? height;
  @HiveField(6)
  late int? weight;
  @HiveField(7)
  late List<String>? abilities;
  @HiveField(8)
  late List<int>? stats;

  /// Only gets the non-nullable parameters, for testing important parts
  Pokemon.essential(this.id, this.name, this.types,this.officialArt,);

  ///full parameter constructor for Pokemon
  Pokemon(this.id, this.name, this.types, this.officialArt,
      this.baseExp,
        this.height, this.weight, this.abilities, this.stats);

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
    final baseExp = data['base_experience'];
    final height = data['height'];
    final weight = data['weight'];
    var list2 = [];
    for(int i = 0; i <= 2; i++) {
      try {
        var current = data['abilities'][i]['ability']['name'];
        list2.add(current);
      }on RangeError {continue;}
    }
    List<String> abilities = list2.map( (i) => i as String).toList();
    var list3 = [];
    for(int i = 0; i <= 5; i++) {
      try {
        var current = data['stats'][i]['base_stat'];
        list3.add(current);
      }on RangeError {continue;}
    }
    List<int> stats = list3.map( (i) => i as int).toList();
    return Pokemon(id,name,types, officialArt,baseExp, height,weight,abilities,stats);
  }

  @override
  String toString() {
    return 'Pokemon{id: $id, name: $name,'
        'types: $types, baseExp: $baseExp, height: $height, weight: $weight, '
        'abilities: $abilities, stats: $stats}';
  }
}


/** the URL to the pokemon's front sprite
    @HiveField(4)
    String?  frontSprite;
    /// the URL to the pokemon's back sprite
    @HiveField(5)
    String? backSprite; */

