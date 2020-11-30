import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';

//Switch que o usuário usa pra escolher ou não ver o botão de emergência
class EmergencySwitch extends StatefulWidget {

  final UserModel model;

  EmergencySwitch(this.model);
  @override
  _EmergencySwitchState createState() => _EmergencySwitchState();
}

class _EmergencySwitchState extends State<EmergencySwitch> {

  bool val;
  @override
  void initState() {
    super.initState();
    val = widget.model.userData["showButton"]; //Pega o dado do usuário para começar
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: val,
      onChanged: (newVal){
        _onChange(newVal);
      },
    );
  }

  //Muda a opção
  _onChange(newVal) {
    setState(() {
      val = newVal;
      widget.model.changeOption(val);
    });
  }


}
