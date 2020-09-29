import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  List<dynamic> phones = List();

  Map<String, dynamic> editedUserData = Map();
  List<dynamic> editedPhones = List();

  static const String default_img = "https://firebasestorage.googleapis.com/v0/b/poizoni.appspot.com/o/profile_pictures%2Fdefault.jpg?alt=media&token=e0685e42-7e23-4eb6-acf7-0b49e055f0a5";

  // usuario atual

  bool isLoading = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"].trim(), password: pass)
        .then((user) async {
      firebaseUser = user;

      userData["img"] = default_img;
      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((error, stackTrace) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      firebaseUser = user;

      await _loadCurrentUser();

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    phones = List();
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    userData["phones"] = phones;
    this.userData = userData;

    await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData["nome"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
        phones = List.from(userData["phones"]);
      }
    }
    notifyListeners();
  }

  void startEdit(){
    editedUserData = Map.from(userData);
    editedPhones = List.from(phones);
  }

  void saveEdit({File img}) async{
    isLoading = true;
    notifyListeners();

    if (img != null)
      await changeImage(img);
    phones = editedUserData["phones"];
    await _saveUserData(editedUserData);

    isLoading = false;
    notifyListeners();
  }

  void changeName(text){
    editedUserData["nome"] = text;
  }

  void addPhone(phone){
    editedPhones.add(phone);
    editedUserData["phones"] = editedPhones;
  }

  void changePhoneLabel(index, text){
    editedUserData["phones"][index]["label"] = text;
  }

  void changePhoneNumber(index, text){
    editedUserData["phones"][index]["number"] = text;
  }

  void deletePhone(index){
    editedPhones.removeAt(index);
    editedUserData["phones"] = editedPhones;
    notifyListeners();
  }

  bool hasImage(){
    return userData["img"] != default_img;
  }

  void removeImage(){
    editedUserData["img"] = default_img;
  }

  Future<Null> changeImage (File img) async{

    //isLoading = true;
    //notifyListeners();

    var fileExtension = path.extension(img.path);

    var uuid = Uuid().v4;

    final StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child("profile_pictures/${firebaseUser.uid}/$uuid$fileExtension)}");

    await firebaseStorageRef.putFile(img).onComplete.catchError((onError){
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();

    editedUserData["img"] = url;

    isLoading = false;
    notifyListeners();
  }

  Future<Null> changeOption (bool val) async{
    userData["showButton"] = val;
    await _saveUserData(userData);
  }

}
