import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../screens/evento.dart';
import '../screens/dia.dart';
import '../mixins/eventosModel.dart';
import '../definitions/colors.dart';

class CardEvento extends StatefulWidget {
  final EventosModel model;
  final DatabaseReference ref;
  final String useruid;
  CardEvento(this.model, this.ref, this.useruid) : super();
  @override
  _CardEventoState createState() {
    return new _CardEventoState();
  }
}

class _CardEventoState extends State<CardEvento> {
  final definitions = ColorsDefinitions();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            //color: definitions.obterLoginColor(),
            color: Colors.grey.shade300,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.model.titulo,
                    style: TextStyle(
                      //color: definitions.obterSplashScreenText(),
                      fontSize: 20.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Evento(widget.model, widget.ref, widget.useruid),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    widget.model.hora,
                    style: TextStyle(
                      //color: definitions.obterSplashScreenText(),
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                             Evento(widget.model, widget.ref, widget.useruid),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CardDia extends StatefulWidget {
  final List<EventosModel> model;
  final String dia;
  final DatabaseReference ref;
  final String useruid;
  CardDia(this.model, this.dia, this.ref, this.useruid) : super();
  @override
  _CardDiaState createState() {
    return new _CardDiaState();
  }
}

class _CardDiaState extends State<CardDia> {
  final definitions = ColorsDefinitions();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            //color: definitions.obterLoginColor(),
            color: Colors.grey.shade300,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(
                    widget.dia,
                    style: TextStyle(
                      //color: definitions.obterSplashScreenText(),
                      fontSize: 20.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            TelaDia(widget.dia, widget.model, widget.ref, widget.useruid),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
