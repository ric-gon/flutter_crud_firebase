import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:armirene_colombia_sas/views_controller.dart';

class SignUpPage extends StatefulWidget {
  final Function(User?) onSignUp;
  // ignore: use_key_in_widget_constructors
  const SignUpPage({required this.onSignUp});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //Variables que almacenan los valores ingresados por el usuario en los form fields
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String error = "";

  Future<void> createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text);
      widget.onSignUp(userCredential.user);
      // ignore: use_build_context_synchronously
      Navigator.pop(
          context,
          MaterialPageRoute(
            builder: ((context) => ViewsController()),
          ));
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
        title: const Text("SignUp Page"),
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
              onPressed: () {
                createUser();
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
