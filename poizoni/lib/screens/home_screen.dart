import 'package:flutter/material.dart';
import 'package:poizoni/tabs/biblioteca_tab.dart';
import 'package:poizoni/tabs/home_tab.dart';
import 'package:poizoni/tabs/map_tab.dart';
import 'package:poizoni/tabs/profile_tab.dart';
import 'package:poizoni/widgets/custom_drawer.dart';
import 'package:poizoni/widgets/edit_user_button.dart';
import 'package:poizoni/widgets/emergency_button.dart';

//Essa é a página principal, que consiste nas 4 abas e muda entre elas
class HomeScreen extends StatefulWidget {

  //É possível passar um índice para abrir em uma das abas
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
    //A PageView controla a página acessada pelo drawer que todas as scaffolds tem
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
