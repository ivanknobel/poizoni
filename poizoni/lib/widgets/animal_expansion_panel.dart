import 'package:flutter/material.dart';
import 'package:poizoni/datas/animal_data.dart';
import 'package:poizoni/datas/expansion_panel_item.dart';

class AnimalExpansionPanel extends StatefulWidget {

  final List<ExpansionPanelItem> data;

  AnimalExpansionPanel(this.data);

  @override
  _AnimalExpansionPanelState createState() => _AnimalExpansionPanelState();
}

class _AnimalExpansionPanelState extends State<AnimalExpansionPanel> {

  @override
  Widget build(BuildContext context) {


    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.data[index].isExpanded = !isExpanded;
        });
      },
      children: widget.data.map<ExpansionPanel>((ExpansionPanelItem item){
        return ExpansionPanel(
          headerBuilder: (context, isExpanded){
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(
              !item.showMore?
              item.expandedValue : item.details,
              style: TextStyle(),
              textAlign: TextAlign.justify,
            ),
            trailing: item.details=="" ?
            null :
            !item.showMore ?
            Icon(Icons.add) : Icon(Icons.remove),
            onTap: (){
              setState(() {
                item.showMore = !item.showMore;
              });
            },
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}