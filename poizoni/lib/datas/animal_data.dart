import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalData{
  String id;

  String nome;
  String desc;
  List<dynamic> images;
  String nomeCientifico;
  String achou; //o que fazer quando achar o animal na natureza
  String atacado; //o que fazer ao ser atacado pelo animal

  String category;

  AnimalData.fromDocument(DocumentSnapshot snapshot)
  {
    id = snapshot.documentID;
    nome = snapshot.data["nome"];
    desc = snapshot.data["descricao"];
    images = snapshot.data["images"];
    nomeCientifico = snapshot.data["nomeCientifico"];
    achou = snapshot.data["achou"];
    atacado = snapshot.data["atacado"];
  }
}
