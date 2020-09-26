import 'package:flutter/material.dart';
import 'package:poizoni/models/user_model.dart';

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
    val = widget.model.userData["showButton"];
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

  _onChange(newVal) {
    setState(() {
      val = newVal;
      widget.model.changeOption(val);
    });
  }


}
