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
  Pokemon.essential(this.id, this.name, this.types,this.officialArt,);

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

List<Pokemon> pokemonForTesting(){
  List<Pokemon> pL = [];
  Pokemon pokemon2 = Pokemon.essential(393, 'piplup',
      [PokemonTypes('water', getTypeColor('water'), getTypeIcon('water')),],
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/393.png');
  pL.add(Pokemon(1, 'bulbasuar', [PokemonTypes('grass', getTypeColor('grass'), getTypeIcon('grass')),
    PokemonTypes('poison', getTypeColor('poison'), getTypeIcon('poison'))],
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png'));
  pL.add(Pokemon(2,'ivysaur',[PokemonTypes('grass',getTypeColor('grass'), getTypeIcon('grass'),),
    PokemonTypes('poison',getTypeColor('poison'), getTypeIcon('poison'),)],
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png'));
  pL.add(Pokemon(3,'venusaur',[PokemonTypes('grass',getTypeColor('grass'), getTypeIcon('grass'),),
    PokemonTypes('poison',getTypeColor('poison'), getTypeIcon('poison'),)],
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png'));
  pL.add(Pokemon(4,'charmander',[PokemonTypes('fire',getTypeColor('fire'), getTypeIcon('fire'),)],
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',));
  pL.add(Pokemon(5,'charmeleon',[PokemonTypes('fire',getTypeColor('fire'), getTypeIcon('fire'),)],'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/5.png',));
  pL.add(Pokemon(6,'charizard',[PokemonTypes('fire',getTypeColor('fire'), getTypeIcon('fire'),), PokemonTypes('flying',getTypeColor('flying'), getTypeIcon('flying'),)],'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png',));
  pL.add(Pokemon(7,'squirtle',[PokemonTypes('water',getTypeColor('water'), getTypeIcon('water'),)],
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png',));
  pL.add(Pokemon(8,'wartortle',[PokemonTypes('water',getTypeColor('water'), getTypeIcon('water'),)],
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/8.png',));
  pL.add(Pokemon(9,'blastoise',[PokemonTypes('water',getTypeColor('water'), getTypeIcon('water'),)],
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/9.png',));
  pL.add(pokemon2);
  return pL;

}

