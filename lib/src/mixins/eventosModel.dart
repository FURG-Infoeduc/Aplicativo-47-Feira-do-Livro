class EventosModel {
  String key;
  String data;
  String descricao;
  String hora;
  String subtitulo;
  String titulo;

  EventosModel(this.key, this.data, this.descricao, this.hora, this.subtitulo,
      this.titulo);

  EventosModel.fromJson(Map<String, dynamic> parsedJson, String id) {
    key = id;
    data = parsedJson['data'] != null ? parsedJson['data'] : '';
    descricao = parsedJson['descricao'] != null ? parsedJson['descricao'] : '';
    hora = parsedJson['hora'] != null ? parsedJson['hora'] : '';
    subtitulo = parsedJson['subtitulo'] != null ? parsedJson['subtitulo'] : '';
    titulo = parsedJson['titulo'] != null ? parsedJson['titulo'] : '';
  }
}
