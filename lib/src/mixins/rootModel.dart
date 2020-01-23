import 'package:firebase_database/firebase_database.dart';
import 'diasModel.dart';
import 'eventosModel.dart';
import 'feedModel.dart';
import 'parceirosModel.dart';
import 'patrocinadoresModel.dart';
import 'organizacaoModel.dart';

class RootModel {
  DatabaseReference referencia;
  DiasModel dias;
  List<EventosModel> eventos = List<EventosModel>();
  List<FeedModel> feed = List<FeedModel>();
  List<ParceirosModel> parceiros = List<ParceirosModel>();
  List<PatrocinadoresModel> patrocinadores = List<PatrocinadoresModel>();
  List<OrganizacaoModel> organizacao = List<OrganizacaoModel>();
  String sobre = '';
  String patrocinador = '';

  RootModel(this.dias, this.eventos, this.feed, this.parceiros,
      this.patrocinadores, this.organizacao, this.referencia);

  RootModel.fromJson(Map<String, dynamic> parsedJson) {
    dias = DiasModel.fromJson(parsedJson['dias']);
    Map<String, dynamic> parsedEvent =
        parsedJson['eventos'] != null ? parsedJson['eventos'] : null;
    List<String> keys;
    if (parsedEvent != null) {
      keys = parsedEvent.keys.toList();
      for (int a = 0; a < keys.length; a++) {
        Map<String, dynamic> parsed = parsedEvent[keys[a]];
        eventos.add(EventosModel.fromJson(parsed, keys[a]));
      }
    }

    parsedEvent = parsedJson['feed'] != null ? parsedJson['feed'] : null;
    if (parsedEvent != null) {
      keys = parsedEvent.keys.toList();
      for (int a = 0; a < keys.length; a++) {
        Map<String, dynamic> parsed = parsedEvent[keys[a]];
        feed.add(FeedModel.fromJson(parsed, keys[a]));
      }
      feed.sort((a, b) => b.key.compareTo(a.key));
    }
    parsedEvent =
        parsedJson['parceiros'] != null ? parsedJson['parceiros'] : null;
    if (parsedEvent != null) {
      keys = parsedEvent.keys.toList();
      for (int a = 0; a < keys.length; a++) {
        Map<String, dynamic> parsed = parsedEvent[keys[a]];
        parceiros.add(ParceirosModel.fromJson(parsed, keys[a]));
      }
      parceiros.sort((a, b) => a.nome.compareTo(b.nome));
    }

    parsedEvent =
        parsedJson['organizacao'] != null ? parsedJson['organizacao'] : null;
    if (parsedEvent != null) {
      keys = parsedEvent.keys.toList();
      for (int a = 0; a < keys.length; a++) {
        Map<String, dynamic> parsed = parsedEvent[keys[a]];
        organizacao.add(OrganizacaoModel.fromJson(parsed, keys[a]));
      }
    }
  }

  RootModel.fromSnapshot(Map<String, dynamic> mapeamento) {

    dias = DiasModel.fromJson(mapeamento['dias']);

    Map<String, dynamic> parsedEvent =
        mapeamento['eventos'] != null ? mapeamento['eventos'] : null;
    List<String> keys;
    if (parsedEvent != null) {
      keys = parsedEvent.keys.toList();
      for (int a = 0; a < keys.length; a++) {
        Map<String, dynamic> parsed = parsedEvent[keys[a]];
        eventos.add(EventosModel.fromJson(parsed, keys[a]));
      }
    }

    parsedEvent = mapeamento['feed'] != null ? mapeamento['feed'] : null;
    if (parsedEvent != null) {
      keys = parsedEvent.keys.toList();
      for (int a = 0; a < keys.length; a++) {
        Map<String, dynamic> parsed = parsedEvent[keys[a]];
        feed.add(FeedModel.fromJson(parsed, keys[a]));
      }
      feed.sort((a, b) => b.key.compareTo(a.key));
    }
    parsedEvent =
        mapeamento['parceiros'] != null ? mapeamento['parceiros'] : null;
    if (parsedEvent != null) {
      keys = parsedEvent.keys.toList();
      for (int a = 0; a < keys.length; a++) {
        Map<String, dynamic> parsed = parsedEvent[keys[a]];
        parceiros.add(ParceirosModel.fromJson(parsed, keys[a]));
      }
      parceiros.sort((a, b) => a.nome.compareTo(b.nome));
    }
    parsedEvent = mapeamento['patrocinadores'] != null
        ? mapeamento['patrocinadores']
        : null;
    if (parsedEvent != null) {
      keys = parsedEvent.keys.toList();
      for (int a = 0; a < keys.length; a++) {
        Map<String, dynamic> parsed = parsedEvent[keys[a]];
        patrocinadores.add(PatrocinadoresModel.fromJson(parsed, keys[a]));
      }
    }
    parsedEvent =
        mapeamento['organizacao'] != null ? mapeamento['patrocinadores'] : null;
    if (parsedEvent != null) {
      parsedEvent = mapeamento['organizacao'];
      keys = parsedEvent.keys.toList();
      for (int a = 0; a < keys.length; a++) {
        Map<String, dynamic> parsed = parsedEvent[keys[a]];
        organizacao.add(OrganizacaoModel.fromJson(parsed, keys[a]));
      }
    }

    parsedEvent = mapeamento['sobre'] != null
        ? mapeamento['sobre']
        : null;
    if (parsedEvent != null) {
      keys = parsedEvent.keys.toList();
      for (int a = 0; a < keys.length; a++) {
        Map<String, dynamic> parsed = parsedEvent[keys[a]];
        sobre = parsed['texto'] != null ? parsed['texto'] : '';
      }
    }

    parsedEvent = mapeamento['patrocinadores'] != null
        ? mapeamento['patrocinadores']
        : null;
    if (parsedEvent != null) {
      keys = parsedEvent.keys.toList();
      for (int a = 0; a < keys.length; a++) {
        Map<String, dynamic> parsed = parsedEvent[keys[a]];
        patrocinador = parsed['texto'] != null ? parsed['texto'] : '';
      }
    }
  }
}
