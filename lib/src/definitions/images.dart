import 'package:flutter/material.dart';

class ImageDefinition {
  Image obterSplashScreenImage() {
    return Image(
      image: AssetImage('assets/images/logo2.png'),
      height: 250,
      width: 250,
      alignment: Alignment.center,
      fit: BoxFit.contain,
    );
  }

  ImageProvider obterPersonImage(String imagem) {
    try {
      if (imagem == '') {
        return AssetImage('assets/images/logo.png');
      } else {
        return NetworkImage(imagem);
      }
    } catch (e) {
      return AssetImage('assets/images/logo.png');
    }
  }
  
  ImageProvider obterLogin() {
    return AssetImage('assets/images/logo.png');
  }
}
