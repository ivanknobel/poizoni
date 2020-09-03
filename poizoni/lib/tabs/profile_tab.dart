import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:poizoni/screens/edit_user_screen.dart';
import 'package:poizoni/screens/nao_logado_screen.dart';
import 'package:poizoni/tiles/phone_tile.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (!model.isLoggedIn())
            return NaoLogadoScreen();
          else if (model.isLoading)
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          else
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(model.userData["img"]),
                                fit: BoxFit.cover
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 20,
                        ),
                        Flexible(
                          child: Container(
                            child: Text(
                              model.userData["nome"],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                  fontSize: 30
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Telefones de emergência:",
                      style: TextStyle(
                          fontSize: 26,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: model.phones.length + 1,
                      itemBuilder: (context, index) {
                        if (index == model.phones.length)
                          return MaterialButton(
                            child: Text("Novo"),
                            onPressed: () {
                              _editProfile(context);
                            },
                          );
                        else
                          return PhoneTile(model.phones[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    ),
                  ],
                ),
              ),
            );
        },
      );
  }

  _editProfile(context) {
    UserModel.of(context).startEdit();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditUserScreen(UserModel.of(context))));
  }
}
