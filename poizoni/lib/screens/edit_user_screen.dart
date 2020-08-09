import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';


class EditUserScreen extends StatefulWidget {

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar perfil"),
        centerTitle: true,

      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
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
                      return _editPhoneCard(context, Map());
                    else
                      return _editPhoneCard(context, model.phones[index]);
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
    );
  }

  Widget _editPhoneCard(context, phone){
    //TODO: mesma coisa que os telefones mas campos de texto para editar (vazios se for um novo) e botao para excluir
    return Container();
  }
}
