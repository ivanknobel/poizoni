import 'package:flutter/material.dart';
import 'package:poizoni/datas/expansion_panel_item.dart';

class AnimalExpansionPanel extends StatefulWidget {

  final List<ExpansionPanelItem> data;
  AnimalExpansionPanel(this.data);

  @override
  _AnimalExpansionPanelState createState() => _AnimalExpansionPanelState();
}

//Painel com as informações do animal
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
              title: Text(
                  item.headerValue,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
            );
          },
          body: ListTile(
            title: Text(
              !item.showMore?
              item.expandedValue : item.details,
              style: TextStyle(

              ),
              textAlign: TextAlign.left,
            ),
            trailing: item.details=="" ?
            null :
            !item.showMore ?
            Icon(Icons.add) : Icon(Icons.remove),
            onTap: (){
              if (item.details!="")
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
