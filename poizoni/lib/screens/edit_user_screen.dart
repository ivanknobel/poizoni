import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class EditUserScreen extends StatefulWidget {
  @override
  _EditUserScreenState createState() => _EditUserScreenState();

  //Recebe o usuário pra editar
  final UserModel model;
  EditUserScreen(this.model);
}

class _EditUserScreenState extends State<EditUserScreen> {
  bool _userEdited = false;
  bool _imageChanged = false;

  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        floatingActionButton: _saveUserButton(),
        appBar: AppBar(
          title: Text("Editar perfil"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            if (model.isLoading)
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              else
                return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(
                            child: Center(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Editar Imagem",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                ),
                                color: Colors.black12,
                                height: 25,
                              ),
                            ),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: !_imageChanged
                                      ? NetworkImage(
                                      model.editedUserData["img"])
                                      : FileImage(_imageFile),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          onTap: () {
                            _userEdited = true;
                            _changeImage(context);
                          },
                        ),
                        SizedBox(
                          height: 100,
                          width: 20,
                        ),
                        Container(
                            width: 200,
                            child: TextFormField(
                              decoration: InputDecoration(labelText: "Nome"),
                              initialValue:
                              model.editedUserData["nome"],
                              onChanged: (text) {
                                _userEdited = true;
                                setState(() {
                                  widget.model.changeName(text);
                                });
                              },
                              style: TextStyle(fontSize: 20),
                            )),
                        SizedBox(
                          height: 100,
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Telefones de emergência:",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:
                      model.editedUserData["phones"].length + 1,
                      itemBuilder: (context, index) {
                        if (index ==
                            model.editedUserData["phones"].length)
                          return _newPhoneCard(context, index);
                        return _editPhoneCard(context, index);
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            );
          },
        )
      ),
    );
  }

  //Card para editar o telefone, onde é possível mudar nome, número ou apagar
  Widget _editPhoneCard(context, index) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              child: TextFormField(
                decoration: InputDecoration(labelText: "Etiqueta"),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    model.changePhoneLabel(index, text);
                  });
                },
                initialValue: model.editedUserData["phones"][index]["label"],
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Número"),
                    onChanged: (text) {
                      _userEdited = true;
                      setState(() {
                        model.changePhoneNumber(index, text);
                      });
                    },
                    initialValue: model.editedUserData["phones"][index]
                    ["number"],
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _userEdited = true;
                    setState(() {
                      model.deletePhone(index);
                    });
                  },
                  icon: Icon(Icons.delete),
                )
              ],
            )
          ],
        );
      },
    );
  }

  //Parecido com o de editar telefone, mas para criar um novo
  Widget _newPhoneCard(context, index) {
    var _formKey = GlobalKey<FormState>();
    var _labelController = TextEditingController();
    var _numberController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: _labelController,
              decoration: InputDecoration(labelText: "Etiqueta"),
              // ignore: missing_return
              validator: (text) {
                if (text.isEmpty) return "Etiqueta inválida!";
              },
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 150,
                child: TextFormField(
                  controller: _numberController,
                  decoration: InputDecoration(labelText: "Número"),
                  keyboardType: TextInputType.phone,
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty) return "Número inválido!";
                  },
                  style: TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _userEdited = true;
                    setState(() {
                      widget.model.addPhone({
                        "label": _labelController.text,
                        "number": _numberController.text.toString()
                      });
                    });
                  }
                },
                icon: Icon(Icons.add),
              )
            ],
          )
        ],
      ),
    );
  }

  //Mostra a barra para escolher a foto e muda ela
  _changeImage(context) {
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
                          _userEdited = true;
                          await _getLocalImage("cam");
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
                              _userEdited = true;
                              await _getLocalImage("gal");
                              //Navigator.pop(context);
                            })),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Remover",
                          style: !widget.model.hasImage() && _imageFile == null
                              ? TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal)
                              : TextStyle(color: Colors.green, fontSize: 20.0),
                        ),
                        onPressed:
                            !widget.model.hasImage() && _imageFile == null
                                ? () {}
                                : () {
                                    _userEdited = true;
                                    setState(() {
                                      widget.model.removeImage();
                                      _imageFile = null;
                                    });
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

  //Pega a imagem
  _getLocalImage(String source) async {
    File imageFile;
    if (source == "gal")
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    else
      imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
        _imageChanged = true;
        //widget.model.changeImage(imageFile);
        Navigator.pop(context);
      });
    }
  }

  //Confirmação quando for sair para o usuário não perder alterações
  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair, as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    widget.model.startEdit();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  //Botão de salvar
  Widget _saveUserButton() {
    return FloatingActionButton(
      child: Icon(
        Icons.save,
        color: Colors.white,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        _requestSave();
      },
    );
  }

  //Confirmação se o usuário quer mesmo salvar e função para salvar
  Future<bool> _requestSave() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Salvar Alterações?"),
              content:
                  Text("Se salvar, as informações anteriores serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    if (_imageFile != null)
                      widget.model.saveEdit(img: _imageFile);
                    else
                      widget.model.saveEdit();
                    Navigator.pop(context);
                    Navigator.pop(context, true); //retorna que deu certo
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      Navigator.pop(context, false);
      return Future.value(true);
    }
  }
}
