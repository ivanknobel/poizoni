import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:poizoni/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

//Botão de emergência
class EmergencyButton extends StatefulWidget {
  @override
  _EmergencyButtonState createState() => _EmergencyButtonState();
}

class _EmergencyButtonState extends State<EmergencyButton> {

  static const max = 4; //Máximo de contatos que vão aparecer

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        if (!model.isLoggedIn())
          return SizedBox(height: 0,);
        else if (!model.userData["showButton"]){
          return SizedBox(height: 0,);
        }
        else //Só vai mostrar se o usuário estiver logado e quiser
          return FloatingActionButton(
            child: Icon(
              Icons.warning,
            ),
            onPressed: (){
              _showPhones(context, model);
            },
            backgroundColor: Colors.amber,
          );
      },
    );
  }

  void _showPhones(context, model){

    showModalBottomSheet(context: context,
        builder: (context){
          return BottomSheet(
            onClosing: (){},
            builder: (context){
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _bottomSheetItems(model),
                  ),
                ),
              );
            },
          );
        }
    );
  }

  List<Widget> _bottomSheetItems(UserModel model){
    List<Widget> ret = [];

    if (!model.isLoggedIn())
      return ret;

    List<Map> phones = List.from(model.userData["phones"]);
    int size = phones.length;

    if (size == 0)
      ret.add(Padding(
        padding: EdgeInsets.all(10.0),
        child: FlatButton(
          child: Text(
            "Adicionar telefones",
            style: TextStyle(color:Colors.green, fontSize: 20.0),
          ),
          onPressed: (){
            _perfil();
          },
        ),
      ));
    else{
      for (int i=0; i<size; i++){
        if (i<max)
          ret.add(_contactTile(phones[i]));
        else{
          ret.add(_moreTile());
          break;
        }
      }
    }

    return ret;
  }

  _moreTile(){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: FlatButton(
        child: Text(
          "Ver todos",
          style: TextStyle(color:Colors.green, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: _perfil,
      ),
    );
  }

  Widget _contactTile(Map phone){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: FlatButton(
        child: Text(
          phone["label"],
          style: TextStyle(color:Colors.green, fontSize: 20.0),
        ),
        onPressed: (){
          launch("tel:${phone["number"]}");
          Navigator.pop(context);
        },
      ),
    );
  }

  _perfil(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(initPage: 3)),
    );
  }
}
