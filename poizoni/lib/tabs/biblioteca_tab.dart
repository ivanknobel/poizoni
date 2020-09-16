import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:poizoni/tiles/biblioteca_tile.dart';

class BibliotecaTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection("animais")
            .orderBy("pos")
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var dividedTiles = ListTile.divideTiles(
                    tiles: snapshot.data.documents.map((doc) {
                      return BibliotecaTile(doc);
                    }).toList(),
                    color: Colors.grey[500])
                .toList();

            return GridView(
              padding: EdgeInsets.all(4.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 2.0,
              ),
              children: dividedTiles,
            );
          }
        });
  }
}
