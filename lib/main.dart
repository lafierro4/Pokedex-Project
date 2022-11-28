import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex_project/FetchPokemon.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  Pokemon pokemon2 = Pokemon(000, 'null', [], 'null');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: PokedexScreen(pokemon: pokemon2));
  }
}

class PokedexScreen extends StatefulWidget {
  final Pokemon pokemon;

  const PokedexScreen({super.key, required this.pokemon});

  @override
  State<StatefulWidget> createState() => _PokedexScreen();
}

class _PokedexScreen extends State<PokedexScreen> {
  List<Pokemon> allPokemon = pokemonForTesting();
  List<Pokemon> filteredPokemon = [];
  final filter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.catching_pokemon),
          title: const Text('Pokedex App'),
          backgroundColor: Colors.red,
        ),
        body: Column(children: <Widget>[
          TextField(
              controller: filter,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search for Pokemon",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.cyan)),
              ),
              onChanged: (value) {
                setState(() {
                  filteredPokemon = allPokemon
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              }),
          Expanded(
              child: GridView.builder(
            itemCount: allPokemon.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 1, mainAxisSpacing: 2),
            itemBuilder: (BuildContext context, int index) {
              return PokemonInfoBox(allPokemon[index]);
            },
          ))
        ]));
  }

  void searchPokemon(String search) {
    final suggestions = allPokemon.where((pokemon) {
      final pokemonName = pokemon.name.toLowerCase();
      final input = search.toLowerCase();
      return pokemonName.contains(input);
    }).toList();
    setState(() => allPokemon = suggestions);
  }
}

class PokedexEntryExpanded extends StatefulWidget {
  final Pokemon pokemon;
  const PokedexEntryExpanded({super.key, required this.pokemon});

  @override
  State<StatefulWidget> createState() => _PokedexEntryExpanded();
}

class _PokedexEntryExpanded extends State<PokedexEntryExpanded> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.pokemon.name);
  }
}
