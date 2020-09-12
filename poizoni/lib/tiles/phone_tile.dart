import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart ';
import 'package:url_launcher/url_launcher.dart';

class PhoneTile extends StatelessWidget {

  final Map phone;

  PhoneTile(this.phone);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phone["label"],
                    style: TextStyle(
                      fontSize: 20,

                    ),
                  ),
                  SizedBox(height: 6,),
                  Text(
                    phone["number"],
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            IconButton(
                icon: Icon(Icons.phone),
                iconSize: 28,
                onPressed: () {
                  launch("tel:${phone["number"]}");
                },
              ),
          ],
        ),
      )
    );
  }
}
