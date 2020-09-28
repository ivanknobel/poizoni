import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:poizoni/screens/edit_user_screen.dart';
import 'package:poizoni/screens/nao_logado_screen.dart';
import 'package:poizoni/tiles/phone_tile.dart';
import 'package:poizoni/widgets/emergency_switch.dart';
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
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                            border: Border.all(
                              color: Colors.black,
                              width: 2
                            )
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
                                fontWeight: FontWeight.w400,
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
                    Row(
                      children: [
                        Text(
                          "Mostrar botão de emergência?",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        EmergencySwitch(model),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Telefones:",
                      style: TextStyle(
                          fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: model.phones.length,
                      itemBuilder: (context, index) {
                          return PhoneTile(model.phones[index]);
                      },
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: _newButton(context, model),
                    )
                  ],
                ),
              ),
            );
        },
      );
  }

  Widget _newButton(context, model){
    return Container(
      child: MaterialButton(
        child: Text(
          "Novo",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
        color: Colors.green[300],
        onPressed: () {
          _editProfile(context, model);
        },
      ),
      width: 200,
    );
  }

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
