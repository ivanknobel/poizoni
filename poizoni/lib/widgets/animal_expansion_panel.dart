import 'package:flutter/material.dart';
import 'package:poizoni/datas/animal_data.dart';

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
    this.details = "",
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
  String details;
}

class AnimalExpansionPanel extends StatefulWidget {

  final AnimalData animal;

  AnimalExpansionPanel(this.animal);

  @override
  _AnimalExpansionPanelState createState() => _AnimalExpansionPanelState();
}

class _AnimalExpansionPanelState extends State<AnimalExpansionPanel> {
  @override
  Widget build(BuildContext context) {

    AnimalData animal = widget.animal;

    List<Item> _data = [
      Item(headerValue: "Descrição", expandedValue: animal.desc),
      Item(headerValue: "O que fazer caso encontre o animal", expandedValue: animal.achou["simples"], details: animal.achou["extendido"]),
      Item(headerValue: "O que fazer caso seja atacado", expandedValue: animal.atacado["simples"], details: animal.atacado["extendido"]),
    ];

    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
          print("INDEX : $index ... $isExpanded");
        });
      },
      children: _data.map<ExpansionPanel>((Item item){
        return ExpansionPanel(
          headerBuilder: (context, isExpanded){
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
