import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileTab extends StatelessWidget {
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
                                "https://miro.medium.com/max/3200/1*g09N-jl7JtVjVZGcd-vL2g.jpeg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 20,
                    ),
                    Text(
                      model.userData["nome"],
                      style: TextStyle(fontSize: 20),
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
                  style: TextStyle(fontSize: 16),
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: model.userData["phones"].length + 1,
                    itemBuilder: (context, index) {
                      if (index == model.userData["phones"].length)
                        return Text("Acabou");
                      else
                        return _phoneCard(context, index);
                    })
              ],
            ),
          );
      },
    );
  }

  Widget _phoneCard(context, index) {
    return Text("TELEFONEEEEE");
  }
}
