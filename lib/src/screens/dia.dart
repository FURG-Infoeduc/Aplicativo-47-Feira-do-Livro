import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../widgets/card.dart';
import '../mixins/eventosModel.dart';
import '../definitions/colors.dart';

class Dia extends StatefulWidget {
  final String dia;
  final List<EventosModel> eventos;
  final DatabaseReference ref;
  final String useruid;
  Dia(this.dia, this.eventos, this.ref, this.useruid) : super();
  @override
  createState() => _DiaState();
}

class _DiaState extends State<Dia> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        children: obterListaCards(widget.eventos, widget.dia, widget.ref),
      ),
    );
  }

  List<Widget> obterListaCards(List<EventosModel> eventos, String dia, DatabaseReference ref) {
    List<EventosModel> eventodia = List<EventosModel>();
    for (int a = 0; a < eventos.length; a++) {
      if (eventos[a].data.substring(0,5) == dia) {
        eventodia.add(eventos[a]);
      }
    }
    eventodia.sort((a, b)=> (a.hora).compareTo(b.hora));
    List<Widget> lista = new List<Widget>();
    for (int a = 0; a < eventodia.length; a++) {
      lista.add(CardEvento(eventodia[a], ref, widget.useruid));
    }
    return lista;
  }
  
}

class TodosDias extends StatefulWidget {
  final List<EventosModel> eventos;
  final List<String> dias;
  final DatabaseReference ref;
  final String useruid;
  TodosDias(this.eventos, this.dias, this.ref, this.useruid) : super();
  @override
  createState() => _TodosDiasState();
}

class _TodosDiasState extends State<TodosDias> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        children: obterListaCards(widget.eventos, widget.dias, widget.ref),
      ),
    );
  }

  List<Widget> obterListaCards(List<EventosModel> eventos, List<String> dias, DatabaseReference ref) {
    List<Widget> lista = new List<Widget>();
    for (int a = 0; a < dias.length; a++) {
      lista.add(CardDia(eventos, dias[a], ref, widget.useruid));
    }
    return lista;
  }
}

class TelaDia extends StatefulWidget {
  final String dia;
  final List<EventosModel> eventos;
  final DatabaseReference ref;
  final String useruid;
  TelaDia(this.dia, this.eventos, this.ref, this.useruid) : super();
  @override
  createState() => _TelaDiaState();
}

class _TelaDiaState extends State<TelaDia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.dia),
        backgroundColor: ColorsDefinitions().obterAppBarColor(),
      ),
      body: ListView(
        children: obterListaCards(widget.eventos, widget.dia, widget.ref),
      ),
    );
  }

  List<Widget> obterListaCards(List<EventosModel> eventos, String dia, DatabaseReference ref) {
    List<EventosModel> eventodia = List<EventosModel>();
    for (int a = 0; a < eventos.length; a++) {
      if (eventos[a].data == dia) {
        eventodia.add(eventos[a]);
      }
    }
    eventodia.sort((a, b)=> (a.hora).compareTo(b.hora));
    List<Widget> lista = new List<Widget>();
    for (int a = 0; a < eventodia.length; a++) {
      lista.add(CardEvento(eventodia[a], ref, widget.useruid));
    }
    return lista;
  }
  
}