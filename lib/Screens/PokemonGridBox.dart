import 'package:flutter/material.dart';
import 'package:pokedex_project/Pokemon/PokemonModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../FetchPokemon.dart';
import '../routes.dart';
import 'Pokedex.dart';
import 'PokemonDetailScreen.dart';




class PokemonGridBox extends StatefulWidget{
  final Pokemon pokemon;
  final List<Pokemon> allPokemon;
  const PokemonGridBox(this.pokemon, this.allPokemon, {super.key});
  @override
  State<StatefulWidget> createState() => _PokemonGridBox();
}

class _PokemonGridBox extends State<PokemonGridBox> {


  Widget getIcon(int index) {
    if (favoritePokemonBox.containsKey(index)) {
      return const Icon(Icons.favorite, color: Colors.red);
    }
    return const Icon(Icons.favorite_border);
  }

  onFavoritePress(int index) {
    if (favoritePokemonBox.containsKey(index)) {
      favoritePokemonBox.delete(index);
      return;
    }
    favoritePokemonBox.put(index, widget.allPokemon[index-1]);
  }
  bool userDrag = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details){
          setState(() {
            userDrag = !userDrag;
            Matrix4.rotationY(44);
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
                  IconButton(
                      icon: getIcon(widget.pokemon.id),
                      onPressed: () =>
                      {
                        onFavoritePress(widget.pokemon.id),
                        setState(() => getIcon(widget.pokemon.id))
                      }
                  ),
                ]),
            child:  AnimatedContainer(
              // transform: userDrag ? Matrix4.rotationY(-1000) : Matrix4.rotationY(250),
      duration: const Duration(seconds: 1),
     child: userDrag ? dragged(widget.pokemon) : normal(widget.pokemon)
    )
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

capitalize(String string){
  return string.replaceFirst(string[0], string[0].toUpperCase());
}

Container normal(Pokemon pokemon){
  bool has2ndType = pokemon.types.asMap().containsKey(1);
  return Container(
      decoration: has2ndType == true ? _TwoTypes(pokemon) : _SingleType(pokemon),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(capitalize(pokemon.name),
        style: const TextStyle(color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold ),
        textAlign: TextAlign.center,),
      Expanded(child: loadPokemonImage(pokemon.officialArt,)),
      Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container( decoration: BoxDecoration(
                color : pokemon.types[0].typeColor,
                border: Border.all(color: Colors.black)),
              height: 30,
              child: Row(children: <Widget>[
                Icon(IconData(pokemon.types[0].typeIcon,fontFamily: 'PokemonTypeIcons')),
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
                      Icon(IconData(pokemon.types[1].typeIcon,fontFamily: 'PokemonTypeIcons')),
                      Text(' ${capitalize(pokemon.types[1].name)} ',
                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                    ],) )
            },
          ]
      )
    ],
  ));
}




Container dragged(Pokemon pokemon){
  bool has2ndType = pokemon.types.asMap().containsKey(1);

  List<Stats> pokemonStats = [
      Stats('Speed', pokemon.stats![5]),
      Stats('Sp. Defence', pokemon.stats![4]),
      Stats('Sp. Attack', pokemon.stats![3]),
      Stats('Defence', pokemon.stats![2]),
      Stats('Attack', pokemon.stats![1]),
      Stats('HP', pokemon.stats![0]),
    ];
  return  Container(
    decoration: has2ndType == true ? _TwoTypes(pokemon) : _SingleType(pokemon),
    child: SfCartesianChart(
            series: <ChartSeries>[
              BarSeries<Stats, String>(
              dataSource: pokemonStats,
              xValueMapper: (Stats stat, _) => stat.name,
              yValueMapper: (Stats stat, _) => stat.value,
              dataLabelSettings:
              const DataLabelSettings(isVisible: true, color: Colors.black),
            ),
          ],
          primaryXAxis: CategoryAxis(labelStyle: TextStyle(color: Colors.black)),
          primaryYAxis:
          NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelStyle: TextStyle(color: Colors.black)
          ),
        )
  );
}


BoxDecoration _SingleType(Pokemon pokemon){
  return BoxDecoration(
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