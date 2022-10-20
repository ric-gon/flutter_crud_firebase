import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'home_page.dart';

// ignore: use_key_in_widget_constructors
class ViewsController extends StatefulWidget {

  @override
  // ignore: library_private_types_in_public_api
  _ViewsControllerState createState() => _ViewsControllerState();
}

class _ViewsControllerState extends State<ViewsController> {
  //inicializa el objeto usuario. Si no hay ninguno el usuario no ha ingresado o no ha creado una cuenta. 
  //De este estado depende la pagina muestra Flutter
  User? user;
  
  //inicializa la funcion onRefreshed y guarda el estado de la sesion anterior del usuario 
  @override
  void initState() {
    super.initState();
    onRefreshed(FirebaseAuth.instance.currentUser);
  }

  onRefreshed(userCred) {
    setState(() {
      user = userCred;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return LoginPage(
        onSignIn: (userCred) => onRefreshed(userCred),
      );
    }
    return HomePage(
      onSignOut: (userCred) => onRefreshed(userCred),
    );
  }
}