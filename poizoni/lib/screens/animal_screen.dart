import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poizoni/datas/animal_data.dart';

class AnimalScreen extends StatelessWidget {
  final AnimalData animal;

  AnimalScreen(this.animal);

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
        appBar: AppBar(
          title: Text(animal.nome),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.3,
              child: Carousel(
                images: animal.images.map((url) {
                  return NetworkImage(url);
                }).toList(),
                dotSize: 6,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                animal.nomeCientifico,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
              child: Text(
                "Descrição: ",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Text(
                animal.desc,
                style: TextStyle(),
                textAlign: TextAlign.justify,
              )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
              child: Text(
                "O que fazer ao achar: ",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Text(
                  animal.achou,
                  style: TextStyle(),
                  textAlign: TextAlign.justify,
                )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
              child: Text(
                "O que fazer caso seja atacado: ",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Text(
                  animal.atacado,
                  style: TextStyle(),
                  textAlign: TextAlign.justify,
                )
            ),
          ],
        ));
  }
}
