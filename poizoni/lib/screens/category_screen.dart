import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poizoni/datas/animal_data.dart';
import 'package:poizoni/tiles/animal_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(snapshot.data["title"]),
        centerTitle: true,
      ),
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