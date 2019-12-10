class DiasModel{
  List<String> dia = List<String>();

  DiasModel(this.dia);
  
  DiasModel.fromJson(Map<String, dynamic> parsedJson){
    List<String> keys = parsedJson.keys.toList();
    keys.sort();
    for(int a = 0; a< keys.length; a++){
      Map<String, dynamic> parsed = parsedJson[keys[a]];
      if(parsed['dia'] != null)
        dia.add(parsed['dia']);
    }
    dia.sort();
  }
}