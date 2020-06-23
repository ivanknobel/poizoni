import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalData{
  String id;

  String nome;
  String desc;
  List<dynamic> images;

  String category;

  AnimalData.fromDocument(DocumentSnapshot snapshot)
  {
    id = snapshot.documentID;
    nome = snapshot.data["nome"];
    desc = snapshot.data["descricao"];
    images = snapshot.data["images"];
  }
}
