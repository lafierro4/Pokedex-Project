import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pokedex_project/Pokemon/PokemonType.dart';
import 'package:pokedex_project/routes.dart';
import 'Pokemon/PokemonModel.dart';


const favoritesBox = 'favorite_pokemon';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(PokemonTypesAdapter());
  Hive.registerAdapter(PokemonAdapter());
  await Hive.openBox<Pokemon>(favoritesBox);
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
      initialRoute: '/home',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

