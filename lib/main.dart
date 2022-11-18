import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex_project/Pokemon/PokemonGridBox.dart';
import 'package:pokedex_project/Pokemon/PokemonModel.dart';
import 'package:pokedex_project/Pokemon/PokemonType.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<Pokemon> getPokemon(String url) async {
  final u =await http.get(Uri.parse(url));
  var data = jsonDecode(u.body);
  Pokemon p = Pokemon.fromJson(data);
  return p;
}

class _MyHomePageState extends State<MyHomePage>{
  Pokemon pokemon = Pokemon(1, 'bulbasuar', [PokemonTypes('grass', getTypeColor('grass'), getTypeIcon('grass')),
    PokemonTypes('poison', getTypeColor('poison'), getTypeIcon('poison'))], 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png');
  Future<Pokemon> pokemon2  = getPokemon('https://pokeapi.co/api/v2/pokemon/piplup/');

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2, children: [PokemonInfoBox(pokemon), PokemonInfoBox(pokemon2 as Pokemon)],);
  }


}
