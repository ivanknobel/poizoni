import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HospitalScreen extends StatelessWidget {
  final hospital;

  HospitalScreen(this.hospital);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hospital"),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: Text(
                hospital.nome,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                child: Icon(Icons.star, color: Colors.yellow)
            ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 4, 8, 0),
                  child: Text(
                    "Endereço: ",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                child: Text(
                  hospital.endereco,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                )
            ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                child: Text(
                  "Aberto agora: ",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  textAlign: TextAlign.justify,
                )
              ),
            if(!hospital.open_now)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                child: Text(
                  "Fechado",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.red),
                  textAlign: TextAlign.justify,
                )
              ),
            if(hospital.open_now)
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  child: Text(
                    "Aberto",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.green),
                    textAlign: TextAlign.justify,
                  )
              ),
          ],
        )
    );
  }
}
