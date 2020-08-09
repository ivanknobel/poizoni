import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileTab extends StatelessWidget {

  final _labelController = TextEditingController();
  final _numberController = TextEditingController();

  Map<String, String> _phone;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        if (!model.isLoggedIn())
          return Container();
        else
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //TODO: adicionar imagem no usuario
                    Container(
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
                    Text(
                      model.userData["nome"],
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 100,
                      width: 20,
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
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
                        return MaterialButton(
                          //TODO: mandar isso pra página de editar perfil
                          child: Text("Novo"),
                          onPressed: (){},
                        );
                      else
                        return _phoneCard(context, model.phones[index]);
                    },
                  separatorBuilder: (context, index){
                      return Divider();
                  },
                ),
              ],
            ),
          );
      },
    );
  }

  Widget _phoneCard(context, phone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            phone["label"],
          style: TextStyle(
            //TODO: style do telefone
          ),
        ),
        Row(
          children: [
            Text(
              phone["number"],
              style: TextStyle(

              ),
            ),
            IconButton(
              icon: Icon(Icons.phone),
              onPressed: (){
                launch("tel:${phone["number"]}");
              },
            )
          ],
        )
      ],
    );
  }

}
