import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../mixins/parceirosModel.dart';
import '../mixins/patrocinadoresModel.dart';
import '../screens/imageviewer.dart';

class SliverGridBuild {
  List<Widget> obterParceirosList(
      List<ParceirosModel> parceiros, BuildContext context) {
    List<Widget> lista = new List<Widget>();
    for (int i = 0; i < parceiros.length; i++) {
      lista.add(
        GestureDetector(
          onTap: () {
            if (!parceiros[i].logo.contains('http')) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ImageViewer(parceiros[i].logo, parceiros[i].nome),
                ),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: 100.0,
                height: 100.0,
                child: CachedNetworkImage(
                  imageUrl: parceiros[i].logo,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    height: 150.0,
                    child: LinearProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                                    'assets/images/' + parceiros[i].logo) !=
                                null
                            ? AssetImage('assets/images/' + parceiros[i].logo)
                            : AssetImage('assets/images/logo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Text(
                parceiros[i].nome,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return lista;
  }

  List<Widget> obterPatrocinadorList(List<PatrocinadoresModel> patrocinadores,
      double fonte, BuildContext context) {
    List<Widget> lista = new List<Widget>();
    for (int i = 0; i < patrocinadores.length; i++) {
      lista.add(GestureDetector(
        // onTap: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (BuildContext context) =>
        //           ImageViewer(patrocinadores[i].logo, patrocinadores[i].nome),
        //     ),
        //   );
        // },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.all(5.0),
              width: 100.0,
              height: 100.0,
              child: CachedNetworkImage(
                imageUrl: patrocinadores[i].logo,
                imageBuilder: (context, imageProvider) => Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  height: 150.0,
                  child: LinearProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Text(
              patrocinadores[i].nome,
              style: TextStyle(
                fontSize: fonte,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ));
    }
    return lista;
  }
}
