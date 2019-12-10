class PatrocinadoresModel {
  String key;
  String logo;
  String nome;
  String tipo;

  PatrocinadoresModel(this.key, this.logo, this.nome, this.tipo);

  PatrocinadoresModel.fromJson(Map<String, dynamic> parsedJson, String id) {
    key = id;
    logo = parsedJson['logo']!= null ? parsedJson['logo'] : '';
    nome = parsedJson['nome']!= null ? parsedJson['nome'] : '';
  }
}
