import 'package:flutter/material.dart';
import '../widgets/slivergrid.dart';
import '../definitions/colors.dart';
import '../mixins/parceirosModel.dart';

class Parceiros extends StatefulWidget {
  final List<ParceirosModel> parceiros;
  Parceiros(this.parceiros) : super();
  @override
  createState() => _ParceirosState();
}

class _ParceirosState extends State<Parceiros> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Parceiros'),
        backgroundColor: ColorsDefinitions().obterAppBarColor(),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverGrid.count(
            crossAxisCount: 2,
            children: SliverGridBuild().obterParceirosList(widget.parceiros, context),
          ),
        ],
      ),
    );
  }
}
