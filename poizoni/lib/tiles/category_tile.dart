import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:poizoni/screens/category_screen.dart';
import 'package:transparent_image/transparent_image.dart';

//Tile pra cada animal
class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>CategoryScreen(snapshot))
        );
      },
      child: Card(
        child: Row(
          children: <Widget>[
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: snapshot.data["icon"],
                  fit: BoxFit.cover,
                  height: 100,
                )
            ),
            Flexible(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      snapshot.data["title"],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}