import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedex_project/FetchPokemon.dart';
import 'package:pokedex_project/Screens/PokemonGridBox.dart';
import 'package:pokedex_project/Pokemon/PokemonModel.dart';
import 'package:pokedex_project/routes.dart';

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
      initialRoute: '/home',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text("Welcome to the Pokedex App",
          style: TextStyle(
            color: Colors.black,
          ),),
      ),
        backgroundColor: Colors.white,
        body: Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height/2.2,
          width: MediaQuery.of(context).size.width,
          child: Container(
          color: Colors.red,
          child: const Text('To start click the white button',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
          ),
          ),
          ),
        ),
      FloatingActionButton(
          onPressed: () =>
          Navigator.of(context).pushNamed('/pokedexGrid'),
          child: CustomPaint(
            painter: _Painter(),
          ),
          shape: const CircleBorder(),
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      ],
    )
    ));
  }
}

class _CirclePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {

  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) {
    return true;
  }

}

class _Painter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    Paint blackLine = Paint()
    ..strokeWidth = 25.0
    ..color = Colors.black;
    Paint circle = Paint()
    ..color = Colors.black;
    circle.style = PaintingStyle.stroke;
    canvas.drawLine(Offset(-200, -20), Offset(0, -20), blackLine);
    canvas.drawLine(const Offset(30, -20),const Offset(200, -20), blackLine);
    canvas.drawCircle(Offset(0, -20), 50, circle);
  }

  @override
  bool shouldRepaint(_Painter delegate){
    return true;
  }

}


class PokedexScreen extends StatefulWidget {

  const PokedexScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PokedexScreen();
}

class _PokedexScreen extends State<PokedexScreen> {
  List<Pokemon> allPokemon = pokemonForTesting();
  List<Pokemon> backup = [];
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
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search for Pokemon",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan)),
              ),
              onChanged: (filter) {
                setState(() {
                  backup = allPokemon;
                  filteredPokemon = allPokemon
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(filter.toLowerCase()))
                      .toList();
                  allPokemon = filteredPokemon;
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
