
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pokedex_project/Screens/PokemonDetailScreen.dart';
import 'Pokemon/PokemonModel.dart';
import 'Screens/FavoritesScreen.dart';
import 'Screens/Pokedex.dart';

class PokemonArguments{
  late final Pokemon pokemon;
  PokemonArguments.pokemon(this.pokemon);
}

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case '/home':
          return MaterialPageRoute(builder: (_) =>
          const PokedexScreen());
      case '/pokemonDetails':
        PokemonArguments arguments = args as PokemonArguments;
          return MaterialPageRoute(builder: (_) =>
              PokemonDetails(pokemon: arguments.pokemon));
      case '/favoritesScreen' :
          return MaterialPageRoute(builder: (_) =>
            const FavoritesScreen());
      default:
          return _errorPage();
    }
  }

  static Route<dynamic> _errorPage(){
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text ('Unexpected Page Route'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}