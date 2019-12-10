import 'package:flutter/material.dart';
import '../widgets/slivergrid.dart';
import '../definitions/colors.dart';
import '../mixins/patrocinadoresModel.dart';

class Patrocinadores extends StatefulWidget {
  final List<PatrocinadoresModel> patrocinadores;
  Patrocinadores(this.patrocinadores) : super();
  @override
  createState() => _PatrocinadoresState();
}

class _PatrocinadoresState extends State<Patrocinadores> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: ColorsDefinitions().obterAppBarColor(),
        title: new Text('Patrocinadores'),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 5.0, left: 5.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverGrid.count(
              crossAxisCount: 2,
              children: SliverGridBuild().obterPatrocinadorList(
                  widget.patrocinadores, 15.0, context),
            ),
          ],
        ),
      ),
    );
  }
}
