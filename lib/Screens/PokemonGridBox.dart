import 'package:flutter/material.dart';
import 'package:pokedex_project/Pokemon/PokemonModel.dart';

import '../FetchPokemon.dart';


class PokemonInfoBox extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonInfoBox(this.pokemon, {super.key});
  @override
  Widget build(BuildContext context){
    return GridTile( header:
    Text(_pokemonID(pokemon.id),
      style: const TextStyle(color: Colors.black, fontSize: 16 ),
      textAlign: TextAlign.left,),
        child: pokemonInfoDisplay(context,pokemon)
    );
  }
}

String _pokemonID(int id){
  if(id < 10){
    return '#00$id';
  }else if(id > 10 && id < 100){
    return '#0$id';
  }else{
    return '#$id';
  }
}

Widget pokemonInfoDisplay(BuildContext context, Pokemon pokemon){
  bool has2ndType = pokemon.types.asMap().containsKey(1);

  capitalize(String string){
    return string.replaceFirst(string[0], string[0].toUpperCase());
  }
  return  Container(
    decoration: has2ndType == true ? _TwoTypes(pokemon) : _SingleType(pokemon),
    child: Column(mainAxisAlignment:MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(capitalize(pokemon.name),
          style: const TextStyle(color: Colors.black, fontSize: 20 ),
          textAlign: TextAlign.center,),
         Expanded(child: loadPokemonImage(pokemon.officialArt,)),
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Container( decoration: BoxDecoration(
                color : pokemon.types[0].typeColor,
                border: Border.all(color: Colors.black)),
              height: 30,
              child: Row(children: <Widget>[
                Icon(pokemon.types[0].typeIcon),
                Text(' ${capitalize(pokemon.types[0].name)} ',
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ],),
            ),
            if(has2ndType)...{
              Container( decoration: BoxDecoration(
                  color : pokemon.types[1].typeColor,
                  border: Border.all(color: Colors.black)),
              height: 30,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                Icon(pokemon.types[1].typeIcon),
                Text(' ${capitalize(pokemon.types[1].name)} ',
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ],) )

            },
        ]
        )
      ],
    ),

  );
}

BoxDecoration _SingleType(Pokemon pokemon){
  return BoxDecoration(
    image: const DecorationImage(
        image: AssetImage('assets/bg_pokeball.png'),
        alignment: Alignment.bottomLeft),
    border: Border.all(color: Colors.black),
    color: pokemon.types[0].typeColor
  );
}

BoxDecoration _TwoTypes(Pokemon pokemon){
  return BoxDecoration(
  border: Border.all(color: Colors.black),
  gradient: LinearGradient(colors: [pokemon.types[0].typeColor, pokemon.types[1].typeColor],
    tileMode: TileMode.repeated
  )
  );
  }