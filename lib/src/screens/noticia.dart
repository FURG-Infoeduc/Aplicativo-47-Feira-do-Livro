import 'package:flutter/material.dart';
import '../definitions/colors.dart';
import '../mixins/feedModel.dart';

class Noticia extends StatefulWidget {
  final FeedModel model;
  Noticia(this.model) : super();
  @override
  createState() => _NoticiaState();
}

class _NoticiaState extends State<Noticia> {
  @override
  Widget build(BuildContext context) {
    final definitions = ColorsDefinitions();
    return Scaffold(
      body: CustomScrollView(
        cacheExtent: 10.0,
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.model.imagemtema,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Text(
                  widget.model.titulo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: definitions.obterDrawerTextColor(),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
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
                      height: 2.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
