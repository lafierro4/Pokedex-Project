
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:pokedex_project/Pokemon/PokemonModel.dart';


var url = 'https://pokeapi.co/api/v2/pokemon?limit=151&offset=0';



Widget pokedexProcess() {
  return Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText('Welcome, to the Pokedex App...',
                    textStyle:
                    const TextStyle(color: Colors.black, fontSize: 25)),
                TyperAnimatedText('Catching the Pokemon...',
                    textStyle:
                    const TextStyle(color: Colors.black, fontSize: 25)),
                TyperAnimatedText('Creating Entries...',
                    textStyle:
                    const TextStyle(color: Colors.black, fontSize: 25)),
              ],
            ),
            const Padding(padding: EdgeInsets.all(20)),
            const CircularProgressIndicator(
              semanticsLabel: 'Making Pokedex',
              color: Colors.red,
              backgroundColor: Colors.white,
            )
          ],
        ),
      ));
}


Future<Image> _imageGet(String imageUrl) async {
  return Image.network(imageUrl, semanticLabel: 'Pokemon Official Artwork',
    height: 100, width: 100, fit: BoxFit.scaleDown,);
}

Widget loadPokemonImage(String imageUrl) {
  var image = _imageGet(imageUrl);
  return FutureBuilder(
    future: image,
    builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
      if (snapshot.hasData) {
        return snapshot.data as Image;
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return pokedexProcess();
      }
    },
  );
}