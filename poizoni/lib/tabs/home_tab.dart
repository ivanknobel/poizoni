import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poizoni/screens/image_return_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String image;
  bool _loading;
  File _image;
  List _outputs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Tflite.close();
    super.dispose();
  }

  pickImage(String source) async {
    Navigator.pop(context);
    setState(() {
      _loading = true;
    });
    var img;
    if (source == "gal")
      img = await ImagePicker.pickImage(source: ImageSource.gallery);
    else
      img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img == null) return null;
    _image = img;
    classifyImage(img);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>
              ImageReturnScreen(_image, _outputs[0]["label"]))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? Container(child: Center(child: CircularProgressIndicator(),))
        : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
                  child: RaisedButton(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: Text(
                        "Pesquisar animal",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      chooseImage(context);
                    },
                  ),
                )
            ],
          ),
      );
  }

  chooseImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Câmera",
                          style: TextStyle(color: Colors.green, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          await pickImage("cam");
                          //Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                            child: Text(
                              "Galeria",
                              style: TextStyle(
                                  color: Colors.green, fontSize: 20.0),
                            ),
                            onPressed: () async {
                              await pickImage("gal");
                              //Navigator.pop(context);
                            })),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.green, fontSize: 20.0),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });

  }
}
