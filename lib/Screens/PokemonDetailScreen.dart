import 'package:flutter/material.dart';
import 'package:pokedex_project/Pokemon/PokemonModel.dart';

class PokemonDetails extends StatefulWidget{
  final Pokemon pokemon;
  


  PokemonDetails({super.key, required this.pokemon});

  @override
  State<StatefulWidget> createState() => _PokemonDetails();

}

class _PokemonDetails extends State<PokemonDetails>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name),
        actions: const <Widget>[
          Icon(Icons.favorite_border)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(image: NetworkImage(widget.pokemon.officialArt)),
          ],
        ),
      ),
    );
  }
  
  
}