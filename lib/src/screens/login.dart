import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:image_picker/image_picker.dart';
import '../authentication/authentication.dart';
import '../authentication/authprovider.dart';
import '../mixins/rootModel.dart';
import '../screens/home.dart';
import '../widgets/dialog.dart';
import '../definitions/colors.dart';
import '../definitions/images.dart';

class Login extends StatefulWidget {
  final RootModel model;
  final VoidCallback onSignedIn;

  Login({this.model, this.onSignedIn});

  @override
  createState() => _LoginState();
}

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email não pode ser vazio' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Senha não pode ser vazia' : null;
  }
}

enum FormType { login, register }

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";
  String _label = 'Login';
  String _label1 = 'Criar Conta';
  ImageProvider _perfil = ImageDefinition().obterLogin();
  File _file;
  bool _aceito = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Future getImage() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
          title: const Text('Fonte da Imagem!'),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Galeria',
              style: TextStyle(
                color: ColorsDefinitions().obterAppBarColor(),
              ),
            ),
            onPressed: () {
              galleryImage();
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              'Câmera',
              style: TextStyle(
                color: ColorsDefinitions().obterAppBarColor(),
              ),
            ),
            onPressed: () {
              photoImage();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future galleryImage() async {
    try {
      var file = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _file = file;
        _perfil = FileImage(file);
      });
    } catch (e) {
      //print(e);
    }
  }

  Future photoImage() async {
    try {
      var file = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _file = file;
        _perfil = FileImage(file);
      });
    } catch (e) {
      //print(e);
    }
  }

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
   
    if (validateAndSave()) {
      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      try {
        final AuthImplementation auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          await auth.signIn(_email, _password, _file);
        } else if (_aceito) {
          await auth.createUser(_email, _password, _file);
        } else {
          Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
          Toast.show('Necessário aceitar os termos de serviço!', context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
        widget.onSignedIn();
       
      } catch (e) {
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
        getErrors(e.toString());
      }
    }
  }

  Future<void> validateAndResetPassword() async {
    if (validateAndSave()) {
      try {
        final AuthImplementation auth = AuthProvider.of(context).auth;
        await auth.requestNewPassword(_email);
        Toast.show(
            'O link de recuperação foi enviado para sua conta de email com sucesso!',
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      } catch (e) {
        getErrors(e.toString());
      }
    }
  }

  void getErrors(String erro) {
    if (erro.contains('ERROR_WRONG_PASSWORD')) {
      Toast.show('Senha inválida', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (erro.contains('ERROR_INVALID_EMAIL')) {
      Toast.show('Email inválido', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (erro.contains('ERROR_USER_NOT_FOUND')) {
      Toast.show('Email não cadastrado', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (erro.contains('ERROR_USER_DISABLED')) {
      Toast.show('Usuário desativado', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (erro.contains('ERROR_TOO_MANY_REQUESTS')) {
      Toast.show(
          'Foram realizadas muitas requisições seguidas aguarde e tente novamente mais tarde',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
    } else if (erro.contains('ERROR_OPERATION_NOT_ALLOWED')) {
      Toast.show('Operação não permitida', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }else{
      Toast.show('Verifique sua coneção a internet', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      _label = 'Registrar';
      _label1 = 'Fazer Login';
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _label = 'Login';
      _label1 = 'Criar Conta';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.86,
                          decoration: BoxDecoration(
                            color: ColorsDefinitions().obterLoginColor(),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(70),
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2.86,
                            child: FlatButton(
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 80,
                                    backgroundImage: _perfil,
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black87,
                                    ),
                                    margin:
                                        EdgeInsets.only(top: 100, left: 100),
                                    child: Icon(
                                      Icons.add_a_photo,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: getImage,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 42),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: 50,
                                padding: EdgeInsets.only(
                                  top: 4,
                                  left: 16,
                                  right: 16,
                                  bottom: 4,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                      ),
                                    ]),
                                child: TextFormField(
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      hintText: 'Email',
                                      icon: Icon(Icons.email)),
                                  validator: EmailFieldValidator.validate,
                                  onSaved: (String value) {
                                    return _email = value.trim();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 32),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: 50,
                                padding: EdgeInsets.only(
                                  top: 4,
                                  left: 16,
                                  right: 16,
                                  bottom: 4,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                      ),
                                    ]),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      hintText: 'Senha',
                                      icon: Icon(Icons.vpn_key)),
                                  validator: PasswordFieldValidator.validate,
                                  onSaved: (String value) {
                                    return _password = value.trim();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                              value: _aceito,
                              onChanged: (value) {
                                setState(
                                  () {
                                    _aceito = value;
                                  },
                                );
                              },
                            ),
                            FlatButton(
                              child: Text(
                                'Aceito termos de serviço',
                                style: TextStyle(
                                    fontSize: 12.5, color: Colors.black),
                              ),
                              onPressed: (() {
                                setState(() {
                                  _aceito = !_aceito;
                                });
                              }),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: FlatButton(
                              child: Text(
                                'Esqueci a senha',
                                style: TextStyle(
                                    fontSize: 12.5, color: Colors.black),
                              ),
                              onPressed: (() {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                validateAndResetPassword();
                              }),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: ColorsDefinitions().obterLoginColor(),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          child: FlatButton(
                            child: Text(
                              _label,
                              style: TextStyle(fontSize: 20.0),
                            ),
                            textColor: Colors.white,
                            onPressed: (() {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              validateAndSubmit();
                            }),
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            _label1,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                          onPressed: _formType == FormType.login
                              ? moveToRegister
                              : moveToLogin,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: FlatButton(
                              child: Text(
                                'Acesso sem cadastro',
                                style: TextStyle(
                                    fontSize: 12.5, color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Home(
                                      model: widget.model,
                                      onSignedOut: null,
                                      user: null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
