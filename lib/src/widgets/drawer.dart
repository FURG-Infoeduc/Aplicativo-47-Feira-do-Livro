import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../authentication/authentication.dart';
import '../authentication/authprovider.dart';
import '../screens/parceiros.dart';
import '../screens/patrocinadores.dart';
import '../screens/desenvolvedores.dart';
import '../screens/organizacao.dart';
import '../screens/imageviewer.dart';
import '../screens/sobre.dart';
import '../screens/login.dart';
import '../mixins/rootModel.dart';
import '../sources/firebase.dart';
import '../definitions/images.dart';
import '../definitions/colors.dart';

class SideMenu extends StatefulWidget {
  final FirebaseMessaging messaging;
  final FirebaseUser user;
  final VoidCallback onSignedOut;
  final RootModel model;

  bool notification;
  SideMenu(this.model, this.onSignedOut, this.user, this.messaging,
      this.notification)
      : super();
  @override
  _SideMenuState createState() {
    return new _SideMenuState();
  }
}

class _SideMenuState extends State<SideMenu> {
  @override
  void initState() {
    widget.messaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: obterItens(),
      ),
    );
  }

  void setNotificationsOnTap() {
    widget.messaging.getToken().then((token) {
      FirebaseDatabaseSnapshot()
          .getTokenSmartphone(widget.model.referencia, token, widget.user)
          .then((valor) {
        FirebaseDatabaseSnapshot()
            .updateTokenSmartphone(
                widget.model.referencia, token, widget.user, valor)
            .then((valor) {
          setState(() {
            widget.notification = valor;
          });
        });
      });
    });
  }

  List<Widget> obterItens() {
    ColorsDefinitions definitions = ColorsDefinitions();
    List<Widget> lista = [
      UserAccountsDrawerHeader(
        margin: EdgeInsets.zero,
        accountName: Text(''),
        accountEmail: Text(
          widget.user == null ? '' : widget.user.email,
          style: TextStyle(color: Colors.white),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: widget.user == null
              ? ImageDefinition().obterPersonImage('')
              : ImageDefinition().obterPersonImage(widget.user.photoUrl),
        ),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: definitions.obterSplashScreenBackground(),
        ),
      ),
      MediaQuery.removePadding(
        context: context,
        // DrawerHeader consumes top MediaQuery padding.
        removeTop: true,
        child: Expanded(
          child: ListView(
            children: obterListView(definitions),
          ),
        ),
      ),
    ];
    return lista;
  }

  List<Widget> obterListView(ColorsDefinitions definitions) {
    List<Widget> lista = [
      ListTile(
        title: Text(
          'Notificação',
          style: TextStyle(
            color: definitions.obterDrawerTextColor(),
          ),
        ),
        leading: Icon(Icons.notifications),
        onTap: widget.user != null ? setNotificationsOnTap : () {},
        trailing: new Checkbox(
          value: widget.notification,
          onChanged: (value) {
            if (widget.user != null) {
              setNotificationsOnTap();
              setState(() {
                widget.notification = value;
              });
            }
          },
        ),
      ),
      Divider(
        color: definitions.obterDrawerTextColor(),
        height: 5.0,
      ),
      ListTile(
        title: Text(
          'Como chegar',
          style: TextStyle(
            color: definitions.obterDrawerTextColor(),
          ),
        ),
        leading: Icon(Icons.place),
        onTap: () {
          launch(
              'https://www.google.com/maps/place/Pra%C3%A7a+Didio+Duh%C3%A1/@-32.1799937,-52.1671133,18z/data=!4m5!3m4!1s0x951185bee204a85f:0x965504031871f398!8m2!3d-32.1803306!4d-52.1664461');
        },
      ),
      Divider(
        color: definitions.obterDrawerTextColor(),
        height: 5.0,
      ),
      ListTile(
          title: Text(
            'Mapa do Evento',
            style: TextStyle(
              color: definitions.obterDrawerTextColor(),
            ),
          ),
          leading: Icon(Icons.map),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ImageViewer('planta-feira-2020.png', 'Mapa do Evento')),
            );
          }),
      Divider(
        color: definitions.obterDrawerTextColor(),
        height: 5.0,
      ),
      ListTile(
        title: Text(
          'Sobre o Evento',
          style: TextStyle(
            color: definitions.obterDrawerTextColor(),
          ),
        ),
        leading: Icon(Icons.info),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  Sobre(sobre: widget.model.sobre),
            ),
          );
        },
      ),
      Divider(
        color: definitions.obterDrawerTextColor(),
        height: 5.0,
      ),
    ];
    if (widget.model.parceiros != null && widget.model.parceiros.length > 0) {
      lista.add(
        ListTile(
          title: Text(
            'Parceiros',
            style: TextStyle(
              color: definitions.obterDrawerTextColor(),
            ),
          ),
          leading: Icon(Icons.people),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    Parceiros(widget.model.parceiros),
              ),
            );
          },
        ),
      );
      lista.add(
        Divider(
          color: definitions.obterDrawerTextColor(),
          height: 5.0,
        ),
      );
    }
    if (widget.model.patrocinadores != null &&
        widget.model.patrocinadores.length > 0) {
      lista.add(
        ListTile(
          title: Text(
            'Patrocinadores',
            style: TextStyle(
              color: definitions.obterDrawerTextColor(),
            ),
          ),
          leading: Icon(Icons.people),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    Patrocinadores(widget.model.patrocinadores),
              ),
            );
          },
        ),
      );
      lista.add(
        Divider(
          color: definitions.obterDrawerTextColor(),
          height: 5.0,
        ),
      );
    }
    if (widget.model.organizacao != null &&
        widget.model.organizacao.length > 0) {
      lista.add(
        ListTile(
          title: Text(
            'Organizadores',
            style: TextStyle(
              color: definitions.obterDrawerTextColor(),
            ),
          ),
          leading: Icon(Icons.people),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    Organizacao(widget.model.organizacao),
              ),
            );
          },
        ),
      );
      lista.add(Divider(
        color: definitions.obterDrawerTextColor(),
        height: 5.0,
      ));
    }
    lista.add(
      ListTile(
        title: Text(
          'Desenvolvedores',
          style: TextStyle(
            color: definitions.obterDrawerTextColor(),
          ),
        ),
        leading: Icon(Icons.code),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Desenvolvedores(),
            ),
          );
        },
      ),
    );
    lista.add(
      Divider(
        color: definitions.obterDrawerTextColor(),
        height: 5.0,
      ),
    );
    if (widget.model.referencia != null) {
      lista.add(
        ListTile(
          title: Text(
            widget.user != null ? 'Logout' : 'Login',
            style: TextStyle(
              color: definitions.obterDrawerTextColor(),
            ),
          ),
          leading: Icon(Icons.exit_to_app),
          onTap: () {
            widget.user != null ? _logout(context) : null;
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    Login(model: widget.model, onSignedIn: widget.onSignedOut),
              ),
            );
          },
        ),
      );
    }
    return lista;
  }

  Future<void> _logout(BuildContext context) async {
    try {
      final AuthImplementation auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}
