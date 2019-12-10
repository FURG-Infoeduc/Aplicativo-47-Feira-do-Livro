import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../mixins/rootModel.dart';
import '../mixins/feedModel.dart';
import '../mixins/jsonModel.dart';
import '../sources/sqlite.dart';

//request por HTTP
class FirebaseJson {
  Future<RootModel> getData() async {
    Response response =
        await get('https://feira-do-livro-6baa6.firebaseio.com/.json');
    RootModel model = RootModel.fromJson(json.decode(response.body));
    return model;
  }
}

//request por API
class FirebaseDatabaseSnapshot {
  Future<RootModel> getData() async {
    DatabaseReference ref;
    RootModel model;
    ref = await FirebaseDatabase.instance.reference();
    await ref.child('conteudo').once().then((DataSnapshot snapshot) async {
      if (snapshot != null) {
        String dados = jsonEncode(snapshot.value);
        Map<String, dynamic> mapeamento = json.decode(dados);
        model = RootModel.fromSnapshot(mapeamento);
        model.referencia = ref;
        JsonModel model1 = JsonModel(dados);
        await SqlLite().insertData(model1);
      }
    }).timeout(Duration(minutes: 2), onTimeout: () async {
      await SqlLite().getData().then((List<Map<String, dynamic>> mapeamento) {
        Map<String, dynamic> maps = json.decode(mapeamento[0]['json']);
        if (maps != null) {
          model = RootModel.fromSnapshot(maps);
        }
      });
    });
    return model;
  }

  Future<List<FeedModel>> getFeedData(DatabaseReference ref) async {
    FeedListModel model;
    ref = await FirebaseDatabase.instance.reference();
    await ref
        .child('conteudo')
        .child('feed')
        .orderByKey()
        .once()
        .then((DataSnapshot snapshot) {
      model = FeedListModel.fromSnapshot(snapshot);
    });
    return model.feed;
  }

  Future<bool> getTokenSmartphone(
      DatabaseReference ref, String token, FirebaseUser user) async {
    bool retorno = false;
    await ref
        .child('administracao')
        .child('tokens')
        .child(user.uid)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value == '-') {
        retorno = false;
      } else {
        retorno = true;
      }
    });
    return retorno;
  }

  Future<bool> updateTokenSmartphone(DatabaseReference ref, String token,
      FirebaseUser user, bool temchave) async {
    bool retorno = false;
    if (temchave) {
      await ref.child('administracao').child('tokens').child(user.uid).set('-');
    } else {
      await ref
          .child('administracao')
          .child('tokens')
          .child(user.uid)
          .set(token);
      retorno = true;
    }
    return retorno;
  }

  Future<void> setEmail(
      DatabaseReference ref, String userid, String email) async {
    await ref.child('administracao').child('emails').child(userid).set(email);
  }
}

//API STORAGE
class FirebaseStorageFiles {
  Future<String> uploadImage(File file, FirebaseUser user) async {
    final StorageReference storageRef = FirebaseStorage.instance.ref();
    final StorageUploadTask uploadTask =
        storageRef.child('users').child(user.uid).putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    return (await downloadUrl.ref.getDownloadURL());
  }
}
