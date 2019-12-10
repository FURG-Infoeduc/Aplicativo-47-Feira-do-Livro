import 'package:flutter/material.dart';
import '../definitions/colors.dart';

class ErrorScreen {
  final definitions = ColorsDefinitions();
  Widget screen() {
    return Scaffold(
      backgroundColor: definitions.obterSplashScreenBackground(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error, color: Colors.white, size: 150.0),
            Text(
              "Dados não disponíveis no momento!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
