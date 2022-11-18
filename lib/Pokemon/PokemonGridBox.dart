import 'package:flutter/material.dart';
import 'package:pokedex_project/Pokemon/PokemonModel.dart';


class PokemonInfoBox extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonInfoBox(this.pokemon, {super.key});
  @override
  Widget build(BuildContext context){
    return GridTile(
      header: Container(color: pokemon.types[0].typeColor,
        child: Text('${pokemon.id}',
          style: const TextStyle(color: Colors.grey),
        textAlign: TextAlign.left,
        )
      ),
        child: pokemonInfoDisplay(pokemon)
    );
  }
}


Widget pokemonInfoDisplay(Pokemon pokemon){
  return Container(
    color: pokemon.types[0].typeColor,
    child: Column( mainAxisAlignment:MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(pokemon.name,
          style: const TextStyle(color: Colors.white, fontSize: 16 ),
          textAlign: TextAlign.center,
        ),
        Row(children: <Widget>[
          Column(children: <Widget>[
            Container(color: pokemon.types[0].typeColor,
            child: Row(children: <Widget>[
              Icon(pokemon.types[0].typeIcon),
              Text(pokemon.types[0].name),
            ],)
            ),
            if(pokemon.types.asMap().containsKey(1))...{
              Container(color: pokemon.types[1].typeColor,
                  child: Row(children: <Widget>[
                    Icon(pokemon.types[1].typeIcon),
                    Text(pokemon.types[1].name),
                  ],)
              ),
            }
          ],),
          Image.network(pokemon.officialArt, fit: BoxFit.cover,),
        ]
        )
      ],
    ),
  );
}