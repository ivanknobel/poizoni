import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poizoni/screens/image_return_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

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

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
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
          MaterialPageRoute(builder: (context)=>ImageReturnScreen(_image, _outputs[0]["label"]))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
        : Stack(children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                    child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    child: GestureDetector(
                      child: SizedBox(
                        height: 350.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 204, 204, 204),
                            border: Border.all(color: Colors.black, width: 2.0),
                          ),
                          child: Center(
                            child: _image == null
                                ? Text("Clique para selecionar uma imagem")
                                : Image.file(_image),
                          ),
                        ),
                      ),
                      onTap: () {
                        pickImage();
                      },
                    ),
                  ),
                )),
                _outputs != null
                    ? SliverToBoxAdapter(
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 80.0),
                            child: SizedBox(
                                height: 80.0,
                                child: Text(
                                  "${_outputs[0]["label"]}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    background: Paint()..color = Colors.white,
                                  ),
                                ))))
                    : SliverToBoxAdapter(
                        child: Container(),
                      ),
                SliverToBoxAdapter(
                    child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 80.0),
                  child: SizedBox(
                    height: 100.0,
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
                        child: IconButton(
                          icon: Icon(Icons.photo_camera),
                          iconSize: 40,
                          onPressed: () {
                            pickImage();
                          },
                        ),
                      ),
                    ),
                  ),
                )),
                SliverToBoxAdapter(
                    child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 10.0),
                  child: RaisedButton(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                      child: Text(
                        "Pesquisar animal",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      pickImage();
                    },
                  ),
                ))
              ],
            )
          ]);
  }
}
