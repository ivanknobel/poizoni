import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 20.0),
              child: GestureDetector(
                child: SizedBox(
                  height: 350.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 204, 204, 204),
                      border: Border.all(
                          color: Colors.black,
                          width: 2.0
                      ),
                    ),
                    child: Center(
                      child: Text("Clique para selecionar uma imagem"),
                    ),
                  ),
                ),
                onTap: (){},
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0),
              child: SizedBox(
                height: 80.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 204, 204, 204),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.photo_camera, size: 40.0,),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
              child: RaisedButton(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
                  child: Text(
                    "Pesquisar animal",
                    style: TextStyle(
                      fontSize: 18.0
                    ),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: (){},
              ),
            )
          ],
        );
  }
}
