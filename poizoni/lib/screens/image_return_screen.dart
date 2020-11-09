import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poizoni/datas/animal_data.dart';
import 'package:poizoni/tabs/map_tab.dart';

import 'animal_screen.dart';
import 'home_screen.dart';

class ImageReturnScreen extends StatelessWidget {
  final img;
  final label;

  ImageReturnScreen(this.img, this.label);

  @override
  Widget build(BuildContext context) {
    bool _achou = true;
    String _id = label.split(" ")[1];
    if (_id == "Outros"){
      _achou = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: _achou ? Text("Animal identificado") : Text("Falha ao identificar animal"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: !_achou ?
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              info(),
              outrosResults(),
              outrosOptions(context),
            ],
          ),
        ) :
        StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance.collection("animais").document("serpentes").collection("items").document(_id).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                AnimalData _animal = AnimalData.fromDocument(snapshot.data);
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    children: [
                      info(),
                      reults(_animal),
                      options(context, _animal)
                    ],
                  ),
                );
              }
            }),
      )
    );
  }

  Widget info(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Imagem analisada:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 10,),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1
            )
          ),
          child: Center(child: Image.file(img)),
        ),
        SizedBox(height: 20,),
      ],
    );
  }

  Widget outrosResults(){
      return Column(
        children: [
            Text(
            "Não foi possível identificar nenhum animal na imagem. Tente novamente com uma foto mais nítida "
            "ou verifique se o animal fotografado está em nossa biblioteca.",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
          ),
          SizedBox(height: 15,)
        ],
      );
  }

  Widget reults(AnimalData animal){
    return Column(
      children: [
        Text(
          "O animal encontrado foi: ${animal.nome}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        SizedBox(height: 10,),
        Text(
          "Deseja ir para a página dele para conhecer mais?",
          style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 15,)
      ],
    );
  }

  Widget outrosOptions(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.arrow_back,),
                SizedBox(width: 5,),
                Text("Voltar", style: TextStyle(fontSize: 16),)
              ],
            ),
          ),
          color: Colors.red,
        ),
        RaisedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(initPage: 1)),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Biblioteca", style: TextStyle(fontSize: 16),),
                SizedBox(width: 5,),
                Icon(Icons.arrow_forward,),
              ],
            ),
          ),
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }

  Widget options(context, AnimalData animal){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.arrow_back,),
                SizedBox(width: 5,),
                Text("Voltar", style: TextStyle(fontSize: 16),)
              ],
            ),
          ),
          color: Colors.red,
        ),
        RaisedButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AnimalScreen(animal)));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(animal.nome, style: TextStyle(fontSize: 16),),
                SizedBox(width: 5,),
                Icon(Icons.arrow_forward,),
              ],
            ),
          ),
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
