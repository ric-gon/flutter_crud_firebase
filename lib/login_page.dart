import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  // Constructor para asignar el valor onSignIn a la clase
  final Function(User?) onSignIn;
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  LoginPage({required this.onSignIn});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  //Variables que almacenan los valores ingresados por el usuario en los form fields
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String error="";

  //funcion que valida si el usuario pertenece a la base de datos en Firebase
  Future<void> loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text);
      widget.onSignIn(userCredential.user);
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message!;
      });
    }
  }
  
  //funcion que asigna un nuevo usuario a la base de datos en Firebase
  Future<void> createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text);
      widget.onSignIn(userCredential.user);
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        //Widget que contiene todo el form incluyendo los botones
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              //height: 100,
              child: Text(error),
            ),
            TextFormField(
              controller: _controllerEmail,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            TextFormField(
              controller: _controllerPassword,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
            ElevatedButton(
              onPressed: () {loginUser();},
              child: const Text("Sign In"),
            ),
            ElevatedButton(
              onPressed: () {createUser();},
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
