import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:poizoni/screens/home_screen.dart';
import 'package:poizoni/tabs/profile_tab.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyButton extends StatefulWidget {
  @override
  _EmergencyButtonState createState() => _EmergencyButtonState();
}

class _EmergencyButtonState extends State<EmergencyButton> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        if (!model.isLoggedIn())
          return SizedBox(height: 0,);
        else
          return FloatingActionButton(
            child: Icon(
              Icons.warning,
            ),
            onPressed: (){
              _showPhones(context, model);
            },
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
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _bottomSheetItems(model),
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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>HomeScreen())
            );

            //Navigator.pop(context);
          },
        ),
      ));
    if (size <= 3){
      for (int i=0; i<size; i++){

      }
    }

    return [
      _contactTile(phones[0]),
      _contactTile(phones[1]),
    ];
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
}
