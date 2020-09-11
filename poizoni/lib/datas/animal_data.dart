import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poizoni/datas/expansion_panel_item.dart';

class AnimalData{
  String id;

  String nome;
  String desc;
  List<dynamic> images;
  String nomeCientifico;
  Map achou; //o que fazer quando achar o animal na natureza
  Map atacado; //o que fazer ao ser atacado pelo animal
  String especies;
  String prevencao;
  String sintomas;

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
    especies = snapshot.data["especies"];
    prevencao = snapshot.data["prevencao"];
    sintomas = snapshot.data["especies"];
  }

  List<ExpansionPanelItem> showData(){
    return [
      ExpansionPanelItem(headerValue: "Descrição", expandedValue: this.desc),
      ExpansionPanelItem(headerValue: "O que fazer caso encontre o animal", expandedValue: this.achou["simples"], details: this.achou["extendido"]),
      ExpansionPanelItem(headerValue: "O que fazer caso seja atacado", expandedValue: this.atacado["simples"], details: this.atacado["extendido"]),
    ];
  }

}
