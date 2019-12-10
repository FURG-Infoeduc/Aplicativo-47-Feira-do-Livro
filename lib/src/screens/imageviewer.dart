import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../definitions/colors.dart';

class ImageViewer extends StatefulWidget {
  final String imagem;
  final String nome;
  ImageViewer(this.imagem, this.nome) : super();
  @override
  createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.nome),
        backgroundColor: ColorsDefinitions().obterAppBarColor(),
      ),
      body: Container(
        child: PhotoView(
          imageProvider: AssetImage("assets/images/" + widget.imagem),
          backgroundDecoration: BoxDecoration(
            color: Colors.white,
          ),
          loadingChild: Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                        ColorsDefinitions().obterAppBarColor(),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
