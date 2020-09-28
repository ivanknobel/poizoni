import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    child:
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
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
                            child: image==null ? Text("Clique para selecionar uma imagem") :
                            Image.file(File(image)),
                          ),
                        ),
                      ),
                        onTap: (){
                          ImagePicker.pickImage(source: ImageSource.gallery).then((file){
                            if (file == null) return;
                            setState(() {
                              image = file.path;
                            });
                          });
                        },
                      ),
                    ),
                  )
              ),
              SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
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
                          child: IconButton
                            (
                            icon: Icon(Icons.photo_camera),
                            iconSize: 40,
                            onPressed: (){
                              ImagePicker.pickImage(source: ImageSource.camera).then((file){
                                if (file == null) return;
                                setState(() {
                                  image = file.path;
                                });
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 10.0),
                    child:
                    RaisedButton(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
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
              )
            ],
          )
        ]
    );
  }
}

