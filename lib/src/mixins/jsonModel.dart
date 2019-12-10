class JsonModel {
  String json;

  JsonModel(this.json);

  Map<String, dynamic> toMap() {
    return {
      'json': json
    };
  }

}