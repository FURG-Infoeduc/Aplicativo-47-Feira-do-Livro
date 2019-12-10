import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../mixins/eventosModel.dart';
import '../mixins/feedModel.dart';
import '../screens/dia.dart';
import '../screens/feed.dart';
import '../screens/qrviewer.dart';

class TabBarBuild {
  List<Widget> obterTabBarList(List<String> dia, bool temFeed) {
    List<Widget> lista = new List<Widget>();
    lista.add(new Tab(
      icon: Icon(Icons.camera_alt),
    ));
    if (temFeed) {
      lista.add(new Tab(
        text: 'Feed',
      ));
    }
    DateTime agora = DateTime.now();
    List<String> aux = _listaDiasVisivel(dia, agora);
    for (int a = 0; a < aux.length; a++) {
        lista.add(new Tab(
        text: aux[a],
      ));
      
    }
    lista.add(new Tab(
      text: 'Todos os dias',
    ));
    return lista;
  }

  List<Widget> obterTabBarItensList(
      List<String> dia,
      List<EventosModel> eventos,
      List<FeedModel> feed,
      DatabaseReference ref,
      FirebaseUser user,
      bool temFeed) {
    List<Widget> lista = new List<Widget>();
    lista.add(CameraApp());
    if (temFeed) {
      lista.add(Feed(feed, ref));
    }
    DateTime agora = DateTime.now();
    List<String> aux = _listaDiasVisivel(dia, agora);
    for (int a = 0; a < aux.length; a++) {
      lista.add(Dia(aux[a], eventos, ref, user == null ? '' : user.uid));
    }
    lista.add(TodosDias(eventos, dia, ref, user == null ? '' : user.uid));
    return lista;
  }

  List<String> _listaDiasVisivel(List<String> dia, DateTime agora) {
    List<String> aux = List<String>();
    int b = 0;
    while (aux.length < 3 && b < dia.length) {
      var spl = dia[b].split('/');
      int ano = int.parse(spl[2]);
      int mes = int.parse(spl[1]);
      int diaa = int.parse(spl[0]);
      DateTime evento = DateTime(ano, mes, diaa);
      if (evento.isAfter(agora)){
        aux.add(dia[b].substring(0,5));
      }else if(evento.compareTo(agora) == 0){
        aux.add("Hoje");
      }
      b += 1;
    }
    return aux;
  }
}
