import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../definitions/colors.dart';

class Desenvolvedores extends StatefulWidget {
  @override
  createState() => _DesenvolvedoresState();
}

class _DesenvolvedoresState extends State<Desenvolvedores> {
  @override
  Widget build(BuildContext context) {
    final definitions = ColorsDefinitions();
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Desenvolvedores'),
        backgroundColor: definitions.obterAppBarColor(),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: 2.0, top: 2.0, right: 10.0, left: 10.0),
                    child: Text(
                      "Aplicativo produzido na disciplina de Atividade de Integração Currícular II, do curso de Sistemas de Informação da Universidade Federal do Rio Grande - FURG, cuja disciplina é orientada pelas professores Átila Astor Weiss, Luciane Baldassari, Pedro de Botelho Marcos,  e Regina Barwaldt.",
                      style: TextStyle(
                        color: definitions.obterDrawerTextColor(),
                        fontSize: 20.0,
                        height: 2.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: 2.0, top: 2.0, right: 10.0, left: 10.0),
                    child: Text(
                      "Aplicativo desenvolvido por:",
                      style: TextStyle(
                        color: definitions.obterDrawerTextColor(),
                        fontSize: 20.0,
                        height: 2.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      launch('https://www.facebook.com/mrjardel.jj.9');
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: 10.0, top: 5.0, right: 10.0, left: 10.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 2.0, top: 2.0, right: 10.0, left: 10.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/jardel.jpg'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                          ),
                          Text(
                            'Jardel Dargas Silva',
                            style: TextStyle(
                              color: definitions.obterDrawerTextColor(),
                              fontSize: 20.0,
                              height: 2.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      launch('https://www.facebook.com/joelson.sartori');
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: 10.0, top: 5.0, right: 10.0, left: 10.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 2.0, top: 2.0, right: 10.0, left: 10.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/joelson.jpg'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                          ),
                          Text(
                            'Joelson Sartory Junior',
                            style: TextStyle(
                              color: definitions.obterDrawerTextColor(),
                              fontSize: 20.0,
                              height: 2.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      launch('https://www.facebook.com/junior.zilles');
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: 10.0, top: 5.0, right: 10.0, left: 10.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 2.0, top: 2.0, right: 10.0, left: 10.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/junior.jpg'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                          ),
                          Text(
                            'Junior Zilles',
                            style: TextStyle(
                              color: definitions.obterDrawerTextColor(),
                              fontSize: 20.0,
                              height: 2.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
