import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poizoni/datas/animal_data.dart';
import 'package:poizoni/widgets/animal_expansion_panel.dart';
import 'package:transparent_image/transparent_image.dart';

class AnimalScreen extends StatelessWidget {
  final AnimalData animal;

  AnimalScreen(this.animal);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme
        .of(context)
        .primaryColor;

    return Scaffold(
        appBar: AppBar(
          title: Text(animal.nome),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
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
                Container(
                  child: AnimalExpansionPanel(animal),
                )
              ],
            )
        )
    );
  }
}

