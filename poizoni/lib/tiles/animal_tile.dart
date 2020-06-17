import "package:flutter/material.dart";
import 'package:poizoni/datas/animal_data.dart';
import 'package:poizoni/screens/biblioteca_screen.dart';

class AnimalTile extends StatelessWidget {

  final String type;
  final AnimalData animal;

  AnimalTile(this.type, this.animal);

  @override
    Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Card(
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                animal.foto,
                fit: BoxFit.cover,
                height: 100.0,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      animal.nome,
                      style: TextStyle(fontWeight: FontWeight.w500),
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
