import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poizoni/datas/animal_data.dart';
import 'package:poizoni/datas/expansion_panel_item.dart';
import 'package:poizoni/widgets/animal_expansion_panel.dart';
import 'package:poizoni/widgets/emergency_button.dart';

class AnimalScreen extends StatefulWidget {

  //Recebe o animal a ser mostrado
  final AnimalData animal;
  AnimalScreen(this.animal);

  @override
  _AnimalScreenState createState() => _AnimalScreenState();
}

class _AnimalScreenState extends State<AnimalScreen> {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    List<ExpansionPanelItem> data = List.from(widget.animal.showData());

    return Scaffold(
        floatingActionButton: EmergencyButton(),
        appBar: AppBar(
          title: Text(widget.animal.nome),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            //Coloca as imagem em um Carousel
            AspectRatio(
              aspectRatio: 1.3,
              child: Carousel(
                images: widget.animal.images.map((url) {
                  return NetworkImage(url); 
                }).toList(),
                dotSize: 6,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,
              ),
            ),
            //Cria um Painel com os dados pegos do animal
            Container(
              child: AnimalExpansionPanel(data),
            ),
            SizedBox(height: 100,)
          ],
        )));
  }

}

