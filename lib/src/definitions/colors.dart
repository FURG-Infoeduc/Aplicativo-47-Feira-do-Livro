import 'package:flutter/material.dart';

class ColorsDefinitions{

  static const MaterialColor lightBlue = const MaterialColor(
    0xFF0277BD,
    const <int, Color>{
      50:  const Color(0xFF0277BD),
      100: const Color(0xFF0277BD),
      200: const Color(0xFF0277BD),
      300: const Color(0xFF0277BD),
      400: const Color(0xFF0277BD),
      500: const Color(0xFF0277BD),
      600: const Color(0xFF0277BD),
      700: const Color(0xFF0277BD),
      800: const Color(0xFF0277BD),
      900: const Color(0xFF0277BD),
    },
  );
  
  Color obterPrimarySwatch(){
    return lightBlue;
  }

  Color obterSplashScreenBackground(){
    return Colors.lightBlue[800];
  }

  Color obterSplashScreenText(){
    return Colors.white;
  }

  Color obterAppBarColor(){
    return Colors.lightBlue[800];
  }

  Color obterLoginColor(){
    return Colors.lightBlue.shade800;
  }

   Color obterDrawerTextColor(){
    return Colors.black;
  }
}