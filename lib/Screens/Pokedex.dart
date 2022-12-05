import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pokedex_project/FetchPokemon.dart';
import 'package:pokedex_project/Pokemon/PokemonType.dart';
import '../Pokemon/PokemonModel.dart';
import '../main.dart';
import 'PokemonGridBox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

late Box<Pokemon> favoritePokemonBox;

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PokedexScreen();
}

class _PokedexScreen extends State<PokedexScreen> {
  List<Pokemon> filteredPokemon = [];
  List<Pokemon> allPokemon = [];
  int index = 51;
  late Future futurePokemon;

  final TextEditingController _filter = TextEditingController();
  final FocusNode _filterFocusNode = FocusNode();
  @override
  void dispose() {
    _filterFocusNode.dispose();
    _filter.dispose();
    super.dispose();
  }

  getPokemon() async {
    for (int i = 1; i <= 50; i++) {
      var response =
          await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$i'));
      var decode = json.decode(response.body);

      allPokemon.add(Pokemon.fromJson(decode));
    }
  }

  @override
  void initState() {
    futurePokemon = getPokemon();
    super.initState();
    favoritePokemonBox = Hive.box(favoritesBox);
  }

  @override
  Widget build(BuildContext context) {
    void loadMorePokemons() async {
      for (int i = index; (i < index + 50) && (index < 905); i++) {
        http.Response response =
            await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$i'));
        final decoded = json.decode(response.body);

        allPokemon.add(Pokemon.fromJson(decoded));
      }
      setState(() {
        allPokemon;
        index += 50;
      });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.filter_alt),),
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
            future: futurePokemon,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return ErrorWidget(NetworkImageLoadException);
                case ConnectionState.waiting:
                  return pokedexProcess();
                case ConnectionState.active:
                case ConnectionState.done:
                  return WillPopScope(
                      onWillPop: () async {
                        return false;
                      },
                      child: Scaffold(
                          appBar: AppBar(
                            leading: const Icon(Icons.catching_pokemon),
                            title: const Text('Pokedex App'),
                            backgroundColor: Colors.red,
                            actions: [
                              IconButton(onPressed: () =>
                                  Navigator.of(context)
                                      .pushNamed('/favoritesScreen'),
                                  icon: Icon(Icons.favorite))
                            ],
                          ),
                          body: Column(children: <Widget>[
                            TextField(
                                controller: _filter,
                                focusNode: _filterFocusNode,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  hintText: "Search for Pokemon",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.cyan)),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                    filteredPokemon = allPokemon
                                        .where((element) => element.name
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                        .toList();
                                  });
                                }),
                            Expanded(
                                child: GridView.builder(
                              itemCount: _filter.text.isNotEmpty
                                  ? filteredPokemon.length
                                  : allPokemon.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 2),
                              itemBuilder: (BuildContext context, int i) {
                                if (i+1 < allPokemon.length) {
                                  if (_filter.text.isEmpty) {
                                    return PokemonGridBox(
                                        allPokemon[i], allPokemon);
                                  } else {
                                    return PokemonGridBox(
                                        filteredPokemon[i], allPokemon);
                                  }
                                } else {
                                  loadMorePokemons();
                                  return AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          margin: const EdgeInsets.all(20),
                                          child:Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: const [ Text("Loading More Pokemon",
                                                  style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                                              CircularProgressIndicator(
                                                semanticsValue: 'Loading',
                                                strokeWidth: 10,
                                            color: Colors.red,
                                            backgroundColor: Colors.white, ) ]
                                          )));
                                }
                              },
                            )),
                          ])));
                default:
                  pokedexProcess();
              }
              return ErrorWidget(UnimplementedError());
            }));
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
