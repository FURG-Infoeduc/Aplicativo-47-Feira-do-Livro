import 'package:flutter/material.dart';
import '../definitions/colors.dart';
import '../definitions/images.dart';

class Splash {
  final definitions = ColorsDefinitions();
  Widget screen() {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: definitions.obterSplashScreenBackground(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //  CircleAvatar(
                      //    backgroundColor:
                      //        definitions.obterSplashScreenText(),
                      //    radius: 80,
                      //    child: ImageDefinition().obterSplashScreenImage(),
                      //  ),
                      ImageDefinition().obterSplashScreenImage(),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      // Text(
                      //   TextDefinition().obterSplashScreenText(),
                      //   style: TextStyle(
                      //     color: definitions.obterSplashScreenText(),
                      //     fontSize: 24.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      //)
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        definitions.obterSplashScreenText(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    //Text()
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
