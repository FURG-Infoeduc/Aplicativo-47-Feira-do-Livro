import 'package:flutter/material.dart';

class ColorsDefinitions{

  static const MaterialColor purple = const MaterialColor(
    0xFF6A1B9A,
    const <int, Color>{
      50:  const Color(0xFF6A1B9A),
      100: const Color(0xFF6A1B9A),
      200: const Color(0xFF6A1B9A),
      300: const Color(0xFF6A1B9A),
      400: const Color(0xFF6A1B9A),
      500: const Color(0xFF6A1B9A),
      600: const Color(0xFF6A1B9A),
      700: const Color(0xFF6A1B9A),
      800: const Color(0xFF6A1B9A),
      900: const Color(0xFF6A1B9A),
    },
  );
  
  Color obterPrimarySwatch(){
    return purple;
  }

  Color obterSplashScreenBackground(){
    return Colors.purple[800];
  }

  Color obterSplashScreenText(){
    return Colors.white;
  }

  Color obterAppBarColor(){
    return Colors.purple[800];
  }

  Color obterLoginColor(){
    return Colors.purple.shade800;
  }

   Color obterDrawerTextColor(){
    return Colors.black;
  }
}