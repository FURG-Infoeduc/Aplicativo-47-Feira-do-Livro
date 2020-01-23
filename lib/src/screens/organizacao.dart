import 'package:flutter/material.dart';
import '../definitions/colors.dart';
import '../definitions/images.dart';
import '../mixins/organizacaoModel.dart';

class Organizacao extends StatefulWidget {
  final List<OrganizacaoModel> organizacao;
  Organizacao(this.organizacao) : super();
  @override
  createState() => _OrganizacaoState();
}

class _OrganizacaoState extends State<Organizacao> {
  @override
  Widget build(BuildContext context) {
    final definitions = ColorsDefinitions();
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Organização'),
        backgroundColor: definitions.obterAppBarColor(),
      ),
      body: ListView(children: obterOrganizacao(widget.organizacao)),
    );
  }

  List<Widget> obterOrganizacao(List<OrganizacaoModel> organizacao) {
    List<Widget> lista = List<Widget>();
    final definitions = ColorsDefinitions();
    for (OrganizacaoModel org in organizacao) {
      var img = ImageDefinition().obterPersonImage(org.imagem);
      lista.add(
        ListTile(
          contentPadding: EdgeInsets.all(15),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            child: Image(image: img,),
          ),
          title: Text(
            org.nome,
            style: TextStyle(
              color: definitions.obterDrawerTextColor(),
              fontSize: 20.0,
              height: 2.0,
            ),
          ),
        ),
      );
      lista.add(
         Divider(
            color: Colors.black,
            height: 5.0,
          )
      );
    }
    return lista;
  }
}
