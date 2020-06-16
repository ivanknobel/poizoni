import 'package:flutter/material.dart';
import 'package:poizoni/screens/biblioteca_screen.dart';
import 'package:poizoni/screens/login_screen.dart';
import 'package:poizoni/tabs/biblioteca_tab.dart';
import 'package:poizoni/tabs/home_tab.dart';
import 'package:poizoni/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Identificar Animal",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            textTheme: Theme.of(context).textTheme,
          ),
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Biblioteca",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            textTheme: Theme.of(context).textTheme,
          ),
          body: BibliotecaTab(),
          drawer: CustomDrawer(_pageController),
        )
      ]
    );
  }
}
