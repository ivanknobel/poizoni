import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  // usuario atual

  bool isLoading = false;

  void signUp({@required Map<String, dynamic> user, @required String pass,
    @required VoidCallback onSucess, @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: user["email"],
        password: pass
    ).then((user) async{
      firebaseUser = user;

      await _saveUserData(userData);

      onSucess();
      isLoading = false;
      notifyListeners();
    }).catchError((e){

      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn() async{
    isLoading = true;
    notifyListeners();

    Future.delayed(Duration(seconds: 3));

    isLoading = false;
    notifyListeners();
  }

  void recoverPass(){

  }

  bool isLoggedIn(){
    return false;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async{
    this.userData = userData;

    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }
}
