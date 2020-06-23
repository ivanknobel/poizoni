import 'package:carousel_pro/carousel_pro.dart';
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
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,
              ),
            ),
            SizedBox( height: 4.0,),
            Text(
              animal.nome
            ),
          ],
        ));
  }
}
