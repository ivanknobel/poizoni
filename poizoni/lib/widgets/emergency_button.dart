import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
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

    List<Map> phones = List.from(model.userData["phones"]);

    showBottomSheet(context: context,
        builder: (context){
          return BottomSheet(
            onClosing: (){},
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          phones[0]["label"],
                          style: TextStyle(color:Colors.green, fontSize: 20.0),
                        ),
                        onPressed: (){
                          launch("tel:${phones[0]["number"]}");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          phones[1]["label"],
                          style: TextStyle(color:Colors.green, fontSize: 20.0),
                        ),
                        onPressed: (){
                          launch("tel:${phones[1]["number"]}");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
    );
  }
}
