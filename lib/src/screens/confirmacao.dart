import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import '../mixins/rootModel.dart';
import '../screens/home.dart';
import '../definitions/colors.dart';

class Confirmacao extends StatefulWidget {
  BuildContext context;
  RootModel model;
  VoidCallback onSignedOut;
  Confirmacao(this.context, this.model, this.onSignedOut) : super();
  @override
  createState() => _ConfirmacaoState();
}

class _ConfirmacaoState extends State<Confirmacao> {
  final definitions = ColorsDefinitions();

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: definitions.obterAppBarColor(), // status bar color
    ));

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 25),
            width: MediaQuery.of(context).size.width / 1.2,
            height: 70,
            decoration: BoxDecoration(
              color: definitions.obterLoginColor(),
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: FlatButton.icon(
              icon: Icon(Icons.home),
              label: Text(
                "Acesso sem registro",
                style: TextStyle(fontSize: 20.0),
              ),
              textColor: Colors.white,
              onPressed: (() {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Home(
                      model: widget.model,
                      onSignedOut: null,
                      user: null,
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.0),
          ),
          widget.model.referencia != null ? obterAcessoEmail(context, widget.onSignedOut) : Container(),
        ],
      ),
    );
  }

  Future<bool> temInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  Widget obterAcessoEmail(BuildContext context, VoidCallback onSignedOut) {
    return Container(
      margin: EdgeInsets.only(left: 25),
      width: MediaQuery.of(context).size.width / 1.2,
      height: 70,
      decoration: BoxDecoration(
        color: definitions.obterLoginColor(),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: FlatButton.icon(
        icon: Icon(Icons.email),
        label: Text(
          "Acesso com e-mail",
          style: TextStyle(fontSize: 20.0),
        ),
        textColor: Colors.white,
        onPressed: (() {
          onSignedOut();
        }),
      ),
    );
  }
}
