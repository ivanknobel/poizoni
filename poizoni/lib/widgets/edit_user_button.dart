import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:poizoni/screens/edit_user_screen.dart';

class EditUserButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!UserModel.of(context).isLoggedIn())
      return SizedBox(height: 0,);
    return FloatingActionButton(
      child: Icon(Icons.edit, color: Colors.white,),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        UserModel.of(context).startEdit();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>EditUserScreen(UserModel.of(context)))
        );
      },
    );
  }
}
