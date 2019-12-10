import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../definitions/colors.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => new _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: RaisedButton(
                color: ColorsDefinitions().obterSplashScreenBackground(),
                textColor: ColorsDefinitions().obterSplashScreenText(),
                splashColor: ColorsDefinitions().obterSplashScreenBackground(),
                onPressed: scan,
                child: const Text('Ler QR Code')),
          )
        ],
      ),
    ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      launch(barcode);
      //setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: const Text('Algo saiu errado!'),
              subtitle: Text('Permissão da camêra não fornecida'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: ColorsDefinitions().obterAppBarColor(),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: const Text('Algo saiu errado!'),
              subtitle: Text('Erro desconhecido: $e'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: ColorsDefinitions().obterAppBarColor(),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } on FormatException {
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: const Text('Algo saiu errado!'),
            subtitle: Text('Erro desconhecido: $e'),
          ),
          actions: <Widget>[
            FlatButton(
              color: ColorsDefinitions().obterAppBarColor(),
              child: Text(
                'Ok',
                style: TextStyle(
                  color: ColorsDefinitions().obterAppBarColor(),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}

class QrReader {
  Future scan(BuildContext context, TabController controller) async {
    try {
      String barcode = await BarcodeScanner.scan();
      //launch(barcode);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: const Text('Leitura realizada'),
              subtitle: Text(barcode),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: ColorsDefinitions().obterAppBarColor(),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      //setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: const Text('Algo saiu errado!'),
              subtitle: Text('Permissão da camêra não fornecida'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: ColorsDefinitions().obterAppBarColor(),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: const Text('Algo saiu errado!'),
              subtitle: Text('Erro desconhecido: $e'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: ColorsDefinitions().obterAppBarColor(),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } on FormatException {
      controller.animateTo(1);
      //Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: const Text('Algo saiu errado!'),
            subtitle: Text('Erro desconhecido: $e'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  color: ColorsDefinitions().obterAppBarColor(),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}
