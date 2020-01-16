import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import '../definitions/colors.dart';

class DataSearch extends SearchDelegate<String> {
  final caminhos = [
    "Entrada Principal - Praça de Alimentação",
    "Entrada Principal - Banheiros",
    "Entrada Principal - Palco Principal",
    "Entrada Principal - Autógrafos e Administração",
    "Entrada Principal - Oficinas",
    "Entrada Principal - Rua das Crianças",
    "Praça de Alimentação - Entrada Principal",
    "Praça de Alimentação - Banheiros",
    "Praça de Alimentação - Palco Principal",
    "Praça de Alimentação - Autógrafos e Administração",
    "Praça de Alimentação - Oficinas",
    "Praça de Alimentação - Rua das Crianças",
    "Banheiros - Entrada Principal",
    "Banheiros - Praça de Alimentação",
    "Banheiros - Palco Principal",
    "Banheiros - Autógrafos e Administração",
    "Banheiros - Oficinas",
    "Banheiros - Rua das Crianças",
    "Palco Principal - Entrada Principal",
    "Palco Principal - Praça de Alimentação",
    "Palco Principal - Banheiros",
    "Palco Principal - Autógrafos e Administração",
    "Palco Principal - Oficinas",
    "Palco Principal - Rua das Crianças",
    "Autógrafos e Administração - Entrada Principal",
    "Autógrafos e Administração - Praça de Alimentação",
    "Autógrafos e Administração - Banheiros",
    "Autógrafos e Administração - Palco Principal",
    "Autógrafos e Administração - Oficinas",
    "Autógrafos e Administração - Rua das Crianças",
    "Oficinas - Entrada Principal",
    "Oficinas - Praça de Alimentação",
    "Oficinas - Banheiros",
    "Oficinas - Palco Principal",
    "Oficinas - Autógrafos e Administração",
    "Oficinas - Rua das Crianças",
    "Rua das Crianças - Entrada Principal",
    "Rua das Crianças - Praça de Alimentação",
    "Rua das Crianças - Banheiros",
    "Rua das Crianças - Palco Principal",
    "Rua das Crianças - Autógrafos e Administração",
    "Rua das Crianças - Oficinas",
  ];
  final recentes = [
    "Entrada Principal - Praça de Alimentação",
    "Entrada Principal - Banheiros",
    "Entrada Principal - Palco Principal",
    "Entrada Principal - Autógrafos e Administração",
    "Entrada Principal - Oficinas",
    "Entrada Principal - Rua das Crianças",
  ];
  AudioPlayer audioPlayer;
  String play = '';
  Future<void> _back(BuildContext context) {
    play = '';
    if (audioPlayer != null) {
      audioPlayer.stop();
    }
    close(context, null);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          play = '';
          if (audioPlayer != null) {
            audioPlayer.stop();
          }
        },
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = ThemeData.dark();
    assert(theme != null);
    return theme.copyWith(
      primaryColor: ColorsDefinitions().obterPrimarySwatch(),
      inputDecorationTheme: InputDecorationTheme(
        focusColor: Colors.white,
        hintStyle: TextStyle(color: Colors.white), //, fontSize: 20.0
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        play = '';
        if (audioPlayer != null) {
          audioPlayer.stop();
        }
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? recentes
        : caminhos
            .where((p) => p.substring(p.indexOf('-')).toLowerCase().contains(query.toLowerCase()))
            .toList();

    return WillPopScope(
      onWillPop: () {
        _back(context);
      },
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            playLocal(suggestionsList[index]);
            if (recentes.indexOf(suggestionsList[index]) == -1)
              recentes.add(suggestionsList[index]);
          },
          leading: Icon(Icons.play_arrow),
          title: Text(suggestionsList[index]),
        ),
        itemCount: suggestionsList.length,
      ),
    );
  }

  Future playLocal(String audio) async {
    if (play != audio) {
      if (audioPlayer != null) {
        audioPlayer.stop();
      }
      audioPlayer = await AudioCache().play('audio/'+audio+'.mp3', volume: 5.0);
      play = audio;
    } else {
      if (audioPlayer != null) {
        audioPlayer.stop();
      }
      play = '';
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? recentes
        : caminhos
            .where((p) => p.substring(p.indexOf('-')).toLowerCase().contains(query.toLowerCase()))
            .toList();

    return WillPopScope(
      onWillPop: () {
        _back(context);
      },
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            playLocal(suggestionsList[index]);
            if (recentes.indexOf(suggestionsList[index]) == -1)
              recentes.add(suggestionsList[index]);
          },
          leading: Icon(Icons.play_arrow),
          title: Text(suggestionsList[index]),
        ),
        itemCount: suggestionsList.length,
      ),
    );
  }
}
