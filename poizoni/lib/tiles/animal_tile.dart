import "package:flutter/material.dart";
import 'package:poizoni/datas/animal_data.dart';
import 'package:poizoni/screens/animal_screen.dart';
import 'package:poizoni/screens/biblioteca_screen.dart';

class AnimalTile extends StatelessWidget {

  final AnimalData animal;

  AnimalTile(this.animal);

  @override
    Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>AnimalScreen(animal))
        );
      },
      child: Card(
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Image.network(
                animal.images[0],
                fit: BoxFit.cover,
                height: 100.0,
              ),
            ),
            Flexible(
              flex: 3,
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
