import 'package:flutter/material.dart';
import 'package:pokedex_project/Pokemon/PokemonModel.dart';

import '../FetchPokemon.dart';


class PokemonInfoBox extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonInfoBox(this.pokemon, {super.key});
  @override
  Widget build(BuildContext context){
    return GridTile( header: Text('#${pokemon.id}',
      style: const TextStyle(color: Colors.black, fontSize: 16 ),
      textAlign: TextAlign.left,),
        child: pokemonInfoDisplay(context,pokemon)
    );
  }
}


Widget pokemonInfoDisplay(BuildContext context, Pokemon pokemon){

  return  Container(
    color:  pokemon.types[0].typeColor,
    child: Column(mainAxisAlignment:MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(pokemon.name.replaceFirst(pokemon.name[0], pokemon.name[0].toUpperCase()),
          style: const TextStyle(color: Colors.black, fontSize: 20 ),
          textAlign: TextAlign.center,),
        Expanded(child:Image.network(pokemon.officialArt, semanticLabel: '${pokemon.name}\'s artwork' ,
          height: 100 ,width: 100, fit: BoxFit.scaleDown,)),
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Container( color: pokemon.types[0].typeColor,
              child: Row(children: <Widget>[
                Icon(pokemon.types[0].typeIcon),
                Text(pokemon.types[0].name),
              ],),
            ),
            if(pokemon.types.asMap().containsKey(1))...{
              Container( color : pokemon.types[1].typeColor,
              child:Row(children: <Widget>[
                Icon(pokemon.types[1].typeIcon),
                Text(pokemon.types[1].name),
              ],) )
            },
        ]
        )
      ],
    ),
  );
}