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
    return Scaffold(backgroundColor: const Color(0xffffffff),
        body: PokedexScreen(pokemon: pokemon2));
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder(
              future: pokemon2,
              builder: (BuildContext context, AsyncSnapshot<Pokemon> futPokemon) {
                if (snapshot.hasData) {
                  return PokedexScreen(pokemon: snapshot.data!);
                } else if(snapshot.hasError){
                    return Text("Error has occurred: ${snapshot.error}");
                  }else{ return pokedexProcess();}
                },
    )
    ));
  }

 */
  }
}
 class PokedexScreen extends StatefulWidget{
  final Pokemon pokemon;

  const PokedexScreen({super.key, required this.pokemon});

  @override
  State<StatefulWidget> createState() => _PokedexScreen();
 }

 class _PokedexScreen extends State<PokedexScreen>{

   List<Pokemon> allPokemon = pokemonForTesting();
   @override
  Widget build(BuildContext context) {
    return GridView.builder( itemCount: allPokemon.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,crossAxisSpacing: 5,mainAxisSpacing: 5),
      itemBuilder: (BuildContext context, int index) {
       return RawMaterialButton(onPressed: () =>{ PokedexEntryExpanded(pokemon: allPokemon[index])},
          child : PokemonInfoBox(allPokemon[index])
     );
        },
    );
  }
 }

 
 class PokedexEntryExpanded extends StatefulWidget{
  final Pokemon pokemon;
  const PokedexEntryExpanded({super.key, required this.pokemon});

  @override
   State<StatefulWidget> createState() => _PokedexEntryExpanded();
 }

class _PokedexEntryExpanded extends State<PokedexEntryExpanded>{
  @override
  Widget build(BuildContext context) {
    return Text(widget.pokemon.name);
  }
  
}