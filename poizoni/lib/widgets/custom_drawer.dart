import 'package:flutter/material.dart';
import 'package:poizoni/tiles/drawer_tile.dart';
import 'package:poizoni/screens/login_screen.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer (this.pageController);

  @override
  Widget build(BuildContext context) {


      Widget _buildDrawerBack() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 203, 241, 200),
                  Colors.white
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
      );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left:32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 16.0, 8.0),
                height: 200.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 35.0,
                      left:0.0,
                      child: Text("Poizoni",
                        style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            child: Text(
                              "Entre ou cadastre-se >",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            onTap: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context)=>LoginScreen())
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.photo_camera, "Identificar Animal", pageController, 0),
              DrawerTile(Icons.book, "Biblioteca", pageController, 1),
              DrawerTile(Icons.local_hospital, "Encontrar Hospitais", pageController, 2),
              DrawerTile(Icons.account_circle, "Você", pageController, 3),
            ],
          ),
        ],
      )
    );
  }
}
