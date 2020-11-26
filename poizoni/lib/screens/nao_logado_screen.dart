import 'package:flutter/material.dart';
import 'package:poizoni/screens/login_screen.dart';
import 'package:poizoni/screens/signup_screen.dart';

//Tela para se o usuário não estiver logado e redirecionar ele pra de login ou criar conta
class NaoLogadoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset("images/snake1_transparent.png"),
            height: 200,
            width: 200,
          ),
          Text(
            "Você não está logado",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Para salvar e acessar telefones de emergência, entre na sua conta ou crie uma agora mesmo!",
            style: TextStyle(
                fontSize: 16
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                child: Text(
                    "Entrar",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen()));
                },
                  color: Theme.of(context).primaryColor
              ),
              SizedBox(width: 30,),
              MaterialButton(
                child: Text(
                    "Criar conta",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignupScreen()));
                },
                color: Theme.of(context).primaryColor,
              )
            ],
          )
        ],
      ),
    );
  }
}
