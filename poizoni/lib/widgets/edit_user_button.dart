import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:poizoni/screens/edit_user_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class EditUserButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        if (!model.isLoggedIn())
          return SizedBox(height: 0,);
        else
          return FloatingActionButton(
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              model.startEdit();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditUserScreen(model)));
            },
          );
      },
    );
  }
}
