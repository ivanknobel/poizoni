import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalData{
  String id;

  String nome;
  String foto;

  String category;

  AnimalData.fromDocument(DocumentSnapshot snapshot)
  {
    id = snapshot.documentID;
    nome = snapshot.data["nome"];
    foto = snapshot.data["foto"];
  }
}
