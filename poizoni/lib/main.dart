import 'package:flutter/material.dart';
import 'package:poizoni/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:poizoni/screens/login_screen.dart';
import 'package:poizoni/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.green[800], //or set color with: Color(0xFF0000FF)
    ));
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: "Poizoni",
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.green[500],
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}