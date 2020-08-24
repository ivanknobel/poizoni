import 'package:flutter/material.dart ';
import 'package:url_launcher/url_launcher.dart';

class PhoneTile extends StatelessWidget {

  final Map phone;

  PhoneTile(this.phone);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          phone["label"],
          style: TextStyle(
            //TODO: style do telefone
          ),
        ),
        Row(
          children: [

            Text(
              phone["number"],
              style: TextStyle(),
            ),
            IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {
                launch("tel:${phone["number"]}");
              },
            )
          ],
        )
      ],
    );
  }
}
