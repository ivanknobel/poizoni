import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';


class EditUserScreen extends StatefulWidget {

  @override
  _EditUserScreenState createState() => _EditUserScreenState();

  final UserModel model;

  EditUserScreen(this.model);
}

class _EditUserScreenState extends State<EditUserScreen> {

  final _nameController = TextEditingController();

  bool _userEdited = false;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Editar perfil"),
          centerTitle: true,

        ),
        body: SingleChildScrollView(
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
                              child: Text("Editar imagem"), //TODO: deixar mais bonito isso
                            ),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.model.userData["img"]
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          onTap: (){
                            _changeImage(context);
                          },
                        ),
                        SizedBox(
                          height: 100,
                          width: 20,
                        ),
                        SizedBox(
                          width: 140,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Nome"),
                            initialValue: widget.model.editedUserData["nome"],
                            onChanged: (text){
                              _userEdited = true;
                              setState(() {
                                widget.model.changeName(text);
                              });
                            },
                            maxLength: 30,

                          )
                        ),
                        SizedBox(
                          height: 100,
                          width: 20,
                        ),
                        IconButton(
                          icon: Icon(Icons.save),
                          onPressed: () {
                            //TODO: salvar as mudancas
                            if (_userEdited)
                              _requestSave();
                            else
                              Navigator.pop(context);
                            //Navigator.pop(context);
                          },
                          alignment: Alignment.centerRight,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Telefones de emergência:",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20,),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.model.editedUserData["phones"].length + 1,
                      itemBuilder: (context, index) {
                        if (index == widget.model.editedUserData["phones"].length)
                          return _newPhoneCard(context, index);
                        return _editPhoneCard(context, index);
                      },
                      separatorBuilder: (context, index){
                        return Divider();
                      },
                    ),
                  ],
                ),
              ),
          ),
        ),
    );
  }

  Widget _editPhoneCard(context, index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 300,
          child: TextFormField(
            decoration: InputDecoration(labelText: "Etiqueta"),
            onChanged: (text){
              _userEdited = true;
              setState(() {
                widget.model.changePhoneLabel(index, text);
              });
            },
            maxLength: 30,
            initialValue: widget.model.editedUserData["phones"][index]["label"],
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 150,
              child: TextFormField(
                decoration: InputDecoration(labelText: "Número"),
                onChanged: (text){
                  _userEdited = true;
                  setState(() {
                    widget.model.changePhoneNumber(index, text);
                  });
                },
                initialValue: widget.model.editedUserData["phones"][index]["number"],
                keyboardType: TextInputType.phone,
              ),
            ),
            IconButton(
              onPressed: (){
                _userEdited = true;
                setState(() {
                  widget.model.deletePhone(index);
                });
              },
              icon: Icon(Icons.delete),
            )
          ],
        )
      ],
    );
  }

  Widget _newPhoneCard(context, index){
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
              maxLength: 30,
              // ignore: missing_return
              validator: (text) {
                if (text.isEmpty)
                  return "Etiqueta inválida!";
              },
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
                    if (text.isEmpty)
                      return "Número inválido!";
                  },
                ),
              ),
              IconButton(
                onPressed: (){
                  if (_formKey.currentState.validate()){
                    _userEdited = true;
                    setState(() {
                      widget.model.addPhone({
                        "label" : _labelController.text,
                        "number" : _numberController.text.toString()
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

  _changeImage(context){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
            onClosing: (){},
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text("Editar",
                          style: TextStyle(color:Colors.green, fontSize: 20.0),),
                        onPressed: (){
                          //TODO: mudar a imagem
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text("Remover",
                          style: !widget.model.hasImage()?
                          TextStyle(color: Colors.grey, fontSize:  20.0, fontWeight: FontWeight.normal) :
                          TextStyle(color:Colors.green, fontSize: 20.0),),
                        onPressed:
                        !widget.model.hasImage()?
                        (){} :
                            (){
                          //TODO: remover a imagem
                              _userEdited = true;
                              setState(() {
                                widget.model.removeImage();
                              });
                              Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text("Cancelar",
                          style: TextStyle(color:Colors.green, fontSize: 20.0),),
                        onPressed: (){
                            Navigator.pop(context);
                          })
                      ),
                  ],
                ),
              );
            },
          );
        }
    );
  }

  Future<bool> _requestPop(){
    if (_userEdited){
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair, as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: (){
                    widget.model.startEdit();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Future<bool> _requestSave(){
    if (_userEdited){
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Salvar Alterações?"),
              content: Text("Se salvar, as informações anteriores serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: (){
                    widget.model.saveEdit();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
