

import 'package:flutter/material.dart';
import '../Pokemon/PokemonModel.dart';
import '../routes.dart';
import 'Pokedex.dart';
import 'PokemonGridBox.dart';


class FavoritesScreen extends StatefulWidget{
  const FavoritesScreen({super.key });

  @override
  State<StatefulWidget> createState() => _FavoritesScreen();

}



class _FavoritesScreen extends State<FavoritesScreen>{
  List<Pokemon> favs = [];

  @override
  void initState() {
    for (int i = 0; i <= 904 && i < favoritePokemonBox.length; i++){
      favs.add(favoritePokemonBox.getAt(i)!);
    }
    super.initState();
  }

  bool userDrag = false;
  @override
  Widget build(BuildContext context) {
    print(favs.length);
    return Scaffold(
        appBar: AppBar(
        leading: const Icon(Icons.catching_pokemon),
    title: const Text('Favorite Pokemon'),
    backgroundColor: Colors.red,
    ),
    body: GridView.builder(
          itemCount: favs.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 2),
          itemBuilder: (BuildContext context, int i) {
               return _FavPokemonTile(favs[i]);
          }
            ),
        );
  }

}

class _FavPokemonTile extends StatefulWidget{
  final Pokemon pokemon;


  const _FavPokemonTile(this.pokemon);

  @override
  State<StatefulWidget> createState() => _FavPokemonTileS();
}

class _FavPokemonTileS extends State<_FavPokemonTile>{

  bool userDrag = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details){
          setState(() {
            userDrag = !userDrag;
          });
        },
        onTap: () => Navigator.of(context).pushNamed('/pokemonDetails',
            arguments: PokemonArguments.pokemon(widget.pokemon)),
        child: GridTile(
            header:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _pokemonID(widget.pokemon.id),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.left,
                  ),
                ]),
            child: userDrag ? dragged(widget.pokemon) :normal(widget.pokemon)
        )
    );
  }
}

String _pokemonID(int id) {
  if (id < 10) {
    return ' #00$id';
  } else if (id >= 10 && id < 100) {
    return ' #0$id';
  } else {
    return ' #$id';
  }
}
