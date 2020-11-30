import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:poizoni/screens/edit_user_screen.dart';
import 'package:scoped_model/scoped_model.dart';

//Botão para editar o usuário
class EditUserButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        if (!model.isLoggedIn())
          return SizedBox(height: 0,); //Se o usuário não está logado, não vai ter a opção de editar
        else
          return FloatingActionButton(
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              _editProfile(context, model);
            },
          );
      },
    );
  }
  //Função pra ir pra página de editar
  //É preciso avisar que está começando a edição e pedir um bool de retorno para a próxima página, para saber se editou ou não
  _editProfile(context, model) async{
    model.startEdit();

    final edited = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditUserScreen(model)),
    );

    if (edited)
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Usuário editado com sucesso!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          )
      );
  }
}
