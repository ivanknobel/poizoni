import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:poizoni/screens/biblioteca_screen.dart';

class BibliotecaTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  BibliotecaTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data["icon"]),
      ),
      title: Text(snapshot.data["title"]),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>BibliotecaScreen(snapshot))
        );
      },
    );
  }
}
