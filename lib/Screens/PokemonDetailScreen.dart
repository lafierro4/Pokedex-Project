import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pokedex_project/Pokemon/PokemonModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PokemonDetails extends StatefulWidget {
  final Pokemon pokemon;

  PokemonDetails({super.key, required this.pokemon});

  @override
  State<StatefulWidget> createState() => _PokemonDetails();
}

class _PokemonDetails extends State<PokemonDetails> {
  List<Stats> pokemonStats = [];

  List<Stats> getPokemonStats() {
    List<Stats> stats = [
      Stats('Speed', widget.pokemon.stats![5]),
      Stats('Sp. Defence', widget.pokemon.stats![4]),
      Stats('Sp. Attack', widget.pokemon.stats![3]),
      Stats('Defence', widget.pokemon.stats![2]),
      Stats('Attack', widget.pokemon.stats![1]),
      Stats('HP', widget.pokemon.stats![0]),
    ];
    return stats;
  }

  @override
  void initState() {
    pokemonStats = getPokemonStats();
    super.initState();
  }

  capitalize(String string) {
    return string.replaceFirst(string[0], string[0].toUpperCase());
  }

  @override
  Widget build(BuildContext context) {

    bool has2ndType = widget.pokemon.types.asMap().containsKey(1);
    return Scaffold(
        appBar: AppBar(
          title: Text(capitalize(widget.pokemon.name)),
        ),
        body: Center(
          child: Container(
            color: widget.pokemon.types[0].typeColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: NetworkImage(widget.pokemon.officialArt),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                ),
                Text(
                  capitalize(widget.pokemon.name),
                  style: TextStyle(fontSize: 40),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(flex: 1,
                          child:
                      Container( decoration: BoxDecoration(
                          color : widget.pokemon.types[0].typeColor,
                          border: Border.all(color: Colors.black)),
                        height: 70,width: MediaQuery.of(context).size.width/2,
                        child: Row(children: <Widget>[
                          Icon(IconData(widget.pokemon.types[0].typeIcon,fontFamily: 'PokemonTypeIcons'),size: 45,),
                          Text(' ${capitalize(widget.pokemon.types[0].name)} ',
                            style: const TextStyle(fontSize: 40,fontWeight: FontWeight.w500),),
                        ],),)
                      ),
                      if(has2ndType)...{
                        Expanded( flex: 1,
                            child:
                        Container( decoration: BoxDecoration(
                            color : widget.pokemon.types[1].typeColor,
                            border: Border.all(color: Colors.black)),
                            height: 70,
                            width: MediaQuery.of(context).size.width/2,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(IconData(widget.pokemon.types[1].typeIcon,fontFamily: 'PokemonTypeIcons'),size: 45,),
                                Text(' ${capitalize(widget.pokemon.types[1].name)} ',
                                  style: const TextStyle(fontSize: 40,fontWeight: FontWeight.w500,),),
                              ],) ) )
                      },
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Height: ${widget.pokemon.height}",
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        "Weight: ${widget.pokemon.weight}",
                        style: TextStyle(fontSize: 25),
                      ),
                    ]),
                SfCartesianChart(
                  title: ChartTitle(text: 'Pokemon Stats', textStyle: TextStyle(color: Colors.black)),
                  series: <ChartSeries>[
                    BarSeries<Stats, String>(
                      dataSource: pokemonStats,
                      xValueMapper: (Stats stat, _) => stat.name,
                      yValueMapper: (Stats stat, _) => stat.value,
                      borderColor: Colors.red,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true, color: Colors.black),
                    ),
                  ],
                  primaryXAxis: CategoryAxis(labelStyle: const TextStyle(color: Colors.black, fontSize: 15)),
                  primaryYAxis:
                      NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift,
                          labelStyle: const TextStyle(color: Colors.black, fontSize: 15)),
                )
              ],
            ),
          ),
        ));
  }
}

class Stats {
  Stats(this.name, this.value);
  final String name;
  final int value;
}
