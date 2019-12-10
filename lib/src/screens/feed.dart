import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../widgets/gesturedetectorcard.dart';
import '../mixins/feedModel.dart';
import '../sources/firebase.dart';

class Feed extends StatefulWidget {
  final DatabaseReference ref;
  List<FeedModel> feed;
  Feed(this.feed, this.ref) : super();
  @override
  createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Widget> cards = new List<Widget>();
  void initState() {
    obterListaCards();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: obterRefresh,
        child: ListView(
          children: cards,
        ),
      ),
    );
  }

  Future<void> obterRefresh() async{
    widget.feed = await FirebaseDatabaseSnapshot().getFeedData(widget.ref);
    setState(() {
      cards = new List<Widget>();
      obterListaCards();
    });
  }

  void obterListaCards() {
    for (int a = 0; a < widget.feed.length; a++) {
      cards.add(CardFeed(widget.feed[a]));
    }
  }
}
