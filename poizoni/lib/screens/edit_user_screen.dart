import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';


class EditUserScreen extends StatefulWidget {

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {

  final _nameController = TextEditingController();
  List<Map> controllers = List();

  bool _userEdited = false;
  Map _editedUserData = Map();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Editar perfil"),
          centerTitle: true,

        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            _editedUserData = model.userData;
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container( //TODO: botar isso num gestureDetector pra dar pra clicar e mudar/excluir a foto
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  model.userData["img"]
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 20,
                      ),
                      Text( //TODO: transformar isso em um textField pra mudar o nome
                        model.userData["nome"],
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(
                        height: 100,
                        width: 20,
                      ),
                      IconButton(
                        icon: Icon(Icons.save),
                        onPressed: () {
                          //TODO: salvar as mudancas
                        },
                        alignment: Alignment.centerRight,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Telefones de emergência:",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20,),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: model.phones.length + 1,
                    itemBuilder: (context, index) {
                      if (index == model.phones.length)
                        return _editPhoneCard(context, index);
                      controllers[index]["name"] = TextEditingController();
                      controllers[index]["number"] = TextEditingController();
                      return _editPhoneCard(context, index);
                    },
                    separatorBuilder: (context, index){
                      return Divider();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _editPhoneCard(context, index){
    //TODO: mesma coisa que os telefones mas campos de texto para editar (vazios se for um novo) e botao para excluir
    return Container();
  }

  Future<bool> _requestPop(){
    if (_userEdited){
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair, as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
