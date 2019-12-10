import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../definitions/colors.dart';
import '../mixins/eventosModel.dart';

class Evento extends StatefulWidget {
  final EventosModel model;
  final DatabaseReference ref;
  final String useruid;
  Evento(this.model, this.ref, this.useruid) : super();
  @override
  createState() => _EventoState();
}

class _EventoState extends State<Evento> {
  final definitions = ColorsDefinitions();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.model.titulo),
        backgroundColor: definitions.obterAppBarColor(),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height / 5,
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    bottom: 5.0, top: 5.0, right: 20.0, left: 20.0),
                child: Text(
                  widget.model.titulo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: definitions.obterDrawerTextColor(),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: 5.0, top: 5.0, right: 20.0, left: 20.0),
                child: Text(
                  widget.model.subtitulo,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: definitions.obterDrawerTextColor(),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: 10.0, top: 5.0, right: 20.0, left: 20.0),
                child: Text(
                  widget.model.descricao,
                  style: TextStyle(
                    color: definitions.obterDrawerTextColor(),
                    fontSize: 17.0,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
