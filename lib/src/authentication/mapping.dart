import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication.dart';
import 'authprovider.dart';
import '../sources/firebase.dart';
import '../mixins/rootModel.dart';
import '../screens/login.dart';
import '../screens/home.dart';
import '../screens/splashPage.dart';
import '../screens/confirmacao.dart';

class MappingPage extends StatefulWidget {
  final RootModel model;

  MappingPage({this.model});

  @override
  createState() => _MappingPageState();
}

enum AuthStatus {
  loading,
  notSignedIn,
  confirmation,
  signIn,
}

class _MappingPageState extends State<MappingPage> {
  AuthStatus _authStatus = AuthStatus.loading;
  FirebaseUser _user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AuthImplementation auth = AuthProvider.of(context).auth;
    auth.getCurrentUser().then((FirebaseUser user) {
      setState(() {
        _user = user;
        _authStatus = user == null ? _authStatus == AuthStatus.loading ? AuthStatus.confirmation : AuthStatus.notSignedIn : AuthStatus.signIn;
      });
    });
  }

  void _signedIn() {
    final AuthImplementation auth = AuthProvider.of(context).auth;
    auth.getCurrentUser().then((FirebaseUser user) {
      FirebaseDatabaseSnapshot().setEmail(widget.model.referencia, user.uid, user.email);
      setState(() {
        _user = user;
        _authStatus = AuthStatus.signIn;
      });
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.loading:
        return Splash().screen();
      case AuthStatus.confirmation:
        return Confirmacao(context, widget.model, _signedOut);
      case AuthStatus.notSignedIn:
        return Login(
            model: widget.model, onSignedIn: _signedIn);
      case AuthStatus.signIn:
        return Home(model: widget.model, onSignedOut: _signedOut, user: _user);
    }
    return null;
  }
}
