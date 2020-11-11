import 'package:flutter/material.dart';
import 'package:poizoni/tabs/biblioteca_tab.dart';
import 'package:poizoni/tabs/home_tab.dart';
import 'package:poizoni/tabs/map_tab.dart';
import 'package:poizoni/tabs/profile_tab.dart';
import 'package:poizoni/widgets/custom_drawer.dart';
import 'package:poizoni/widgets/edit_user_button.dart';
import 'package:poizoni/widgets/emergency_button.dart';

class HomeScreen extends StatefulWidget {

  final int initPage;

  HomeScreen({this.initPage});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  PageController _pageController;


  @override
  void initState() {
    super.initState();
    if (widget.initPage != null)
      _pageController = PageController(initialPage: widget.initPage);
    else
      _pageController = PageController();
  }

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
            floatingActionButton: EmergencyButton(),
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
            floatingActionButton: EmergencyButton(),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text(
                "Encontrar Hospitais",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              textTheme: Theme.of(context).textTheme,
            ),
            body: MapTab(),
            drawer: CustomDrawer(_pageController),
          ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Perfil",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
            body: ProfileTab(),
            drawer: CustomDrawer(_pageController),
            floatingActionButton: EditUserButton(),
          )
        ]
    );
  }
}
