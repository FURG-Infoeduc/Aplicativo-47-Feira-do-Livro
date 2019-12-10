import 'package:feira_do_livro/src/screens/qrviewer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fab_menu/fab_menu.dart';
import '../widgets/drawer.dart';
import '../widgets/tabbar.dart';
import '../mixins/rootModel.dart';
import '../definitions/text.dart';
import '../definitions/colors.dart';
import '../sources/firebase.dart';
import '../screens/pesquisa.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;
  final RootModel model;
  final VoidCallback onSignedOut;

  Home({this.model, this.onSignedOut, this.user});
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _controller;
  final FirebaseMessaging _messaging = FirebaseMessaging();
  bool _temFeed = false;
  bool _notificacao = false;
  List<MenuData> menuDataList = new List<MenuData>();

  @override
  void initState() {
    _messaging.configure(
      onMessage: (Map<String, dynamic> message) {
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text(message["notification"]["title"]),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(message["notification"]["body"])],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: ColorsDefinitions().obterAppBarColor(),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onResume: (Map<String, dynamic> message) {
        //print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {},
    );
    var add = widget.model.feed.length > 0 ? 1 : 0;
    _temFeed = add == 1 ? true : false;
    int _aux = _qtdDiasVisivel(widget.model.dias.dia, DateTime.now());
    _controller = new TabController(
      vsync: this,
      length: _aux + add + 2,
      initialIndex: 1,
    );
    if (widget.user != null) {
      _setNotificationsOnStart();
    }
    _controller.addListener(_handleTabSelection);
    menuDataList.add(
      new MenuData(Icons.camera_alt, (context, menuData) {
        QrReader().scan(context, _controller);
      }, labelText: 'QR code'),
    );
    menuDataList.add(
      new MenuData(Icons.home, (context, menuData) {
        setState(() {
          _controller.animateTo(1);
        });
      }, labelText: 'Feed'),
    );
    menuDataList.add(
      new MenuData(Icons.calendar_today, (context, menuData) {
        setState(() {
          int index = _controller.length;
          _controller.animateTo(index - 1);
        });
      }, labelText: 'Visualizar todos os dias'),
    );
    super.initState();
  }

  int _qtdDiasVisivel(List<String> dia, DateTime agora) {
    List<String> aux = List<String>();
    int b = 0;
    while (aux.length < 3 && b < dia.length) {
      var spl = dia[b].split('/');
      int ano = int.parse(spl[2]);
      int mes = int.parse(spl[1]);
      int diaa = int.parse(spl[0]);
      DateTime evento = DateTime(ano, mes, diaa);
      if (evento.isAfter(agora) || evento.compareTo(agora) == 0) {
        aux.add(dia[b]);
      }

      b += 1;
    }
    return aux.length;
  }

  void _handleTabSelection() {
    if (_controller.index == 0) {
      QrReader().scan(context, _controller);
    }
  }

  void _setNotificationsOnStart() {
    _messaging.getToken().then((token) {
      FirebaseDatabaseSnapshot()
          .getTokenSmartphone(widget.model.referencia, token, widget.user)
          .then((valor) {
        if (valor) {
          FirebaseDatabaseSnapshot()
              .updateTokenSmartphone(
                  widget.model.referencia, token, widget.user, !valor)
              .then((valor) {
            setState(() {
              _notificacao = valor;
            });
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _back() {
    if (_controller.index != 1) {
      setState(() {
        _controller.animateTo(1);
      });
    } else {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Deseja sair?'),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Não',
                    style: TextStyle(
                      color: ColorsDefinitions().obterAppBarColor(),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                FlatButton(
                  child: Text(
                    'Sim',
                    style: TextStyle(
                      color: ColorsDefinitions().obterAppBarColor(),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          ) ??
          false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _back,
      child: Scaffold(
        appBar: AppBar(
          title: Text(TextDefinition().obterAppHomeText()),
          bottom: TabBar(
            onTap: (valor) {
              if (valor == 0) {
                _controller.animateTo(1);
              }
            },
            isScrollable: true,
            controller: _controller,
            tabs:
                TabBarBuild().obterTabBarList(widget.model.dias.dia, _temFeed),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
          ],
          backgroundColor: ColorsDefinitions().obterAppBarColor(),
        ),
        body: TabBarView(
          controller: _controller,
          children: TabBarBuild().obterTabBarItensList(
              widget.model.dias.dia,
              widget.model.eventos,
              widget.model.feed,
              widget.model.referencia,
              widget.user,
              _temFeed),
        ),
        drawer: SideMenu(widget.model, widget.onSignedOut, widget.user,
            _messaging, _notificacao),
        floatingActionButton: new FabMenu(
          menus: menuDataList,
          maskColor: Colors.black,
          mainIcon: Icons.calendar_today,
        ),
        floatingActionButtonLocation: fabMenuLocation,
      ),
    );
  }
}
