

import 'package:flutter/material.dart';
import 'package:pokedex_project/Screens/PokemonDetailScreen.dart';
import 'package:pokedex_project/main.dart';
import 'Pokemon/PokemonModel.dart';

class _PokemonArguments{
  late final Pokemon pokemon;
  _PokemonArguments(this.pokemon);
}

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case '/home': return MaterialPageRoute(builder: (_)=>
      const MyHomePage()
      );
      case '/pokedexGrid':
          return MaterialPageRoute(builder: (_) =>
          const PokedexScreen());
      case 'pokemonDetails':
        _PokemonArguments arguments = args as _PokemonArguments;
          return MaterialPageRoute(builder: (_) =>
              PokemonDetails(pokemon: arguments.pokemon));
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