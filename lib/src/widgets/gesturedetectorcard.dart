import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../mixins/feedModel.dart';
import '../screens/noticia.dart';

class CardFeed extends StatefulWidget {
  final FeedModel model;
  CardFeed(this.model) : super();
  @override
  _CardFeedState createState() {
    return new _CardFeedState();
  }
}

class _CardFeedState extends State<CardFeed> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Noticia(widget.model),
          ),
        );
      },
      child: Card(
        child: new Column(
          children: <Widget>[
            widget.model.imagemtema != null
                ? CachedNetworkImage(
                    imageUrl: widget.model.imagemtema,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      height: 150.0,
                      child: LinearProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                : Container(),
            ListTile(
              title: Text(widget.model.titulo),
            )
          ],
        ),
      ),
    );
  }
}
