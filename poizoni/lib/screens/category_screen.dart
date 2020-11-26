import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poizoni/datas/animal_data.dart';
import 'package:poizoni/tiles/animal_tile.dart';
import 'package:poizoni/widgets/emergency_button.dart';

class CategoryScreen extends StatelessWidget {

  //Recebe um snapshot que é a categoria a ser mostrada na página
  final DocumentSnapshot snapshot;
  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: EmergencyButton(),
      appBar: AppBar(
        title: Text(snapshot.data["title"]),
        centerTitle: true,
      ),
      //Aqui ele vai pegar os dados dos animais da categoria e criar a lista, com um AnimalTile pra cada animal
      body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("animais").document(snapshot.documentID).collection("items").getDocuments(),
          builder: (context, snapshot){
            if(!snapshot.hasData)
              return Center(child: CircularProgressIndicator(),);
            else{
              return ListView.builder(
                  padding: EdgeInsets.all(4.0),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index){
                    return AnimalTile(AnimalData.fromDocument(snapshot.data.documents[index]));
                  });
            }
          }
      ),
    );
  }
}