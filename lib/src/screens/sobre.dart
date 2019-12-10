import 'package:flutter/material.dart';
import '../definitions/colors.dart';

class Sobre extends StatefulWidget {
  String sobre;
  Sobre({this.sobre});
  @override
  createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    final definitions = ColorsDefinitions();
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Sobre o Evento'),
        backgroundColor: definitions.obterAppBarColor(),
      ),
      body: CustomScrollView(
        cacheExtent: 10.0,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.only(
                      bottom: 10.0, top: 5.0, right: 20.0, left: 20.0),
                  child: Text(
                    widget.sobre,
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
