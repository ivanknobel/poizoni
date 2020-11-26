import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:poizoni/tiles/category_tile.dart';

class BibliotecaTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Pega as categorias de animais e cria uma lista de Tiles para elas
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("animais").getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return ListView.builder(
                padding: EdgeInsets.all(6),
                itemCount: snapshot.data.documents.length + 1,
                itemBuilder: (context, index) {
                  if (index >= snapshot.data.documents.length)
                    return SizedBox(
                      height: 100,
                    );
                  else
                    return CategoryTile(snapshot.data.documents[index]);
                });
        });
  }
}
