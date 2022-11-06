import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:armirene_colombia_sas/pages/sign_up_page.dart';
import 'package:armirene_colombia_sas/widgets/custom_alert_dialog.dart';

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

  String error = "";
  
  Future<void> _showMyDialog(txt1, txt2, txtBttn1) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (_) => CustomAlertDialog(text1: txt1, text2: txt2, textButton1: txtBttn1));
  }

  Future<void> loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text);
      widget.onSignIn(userCredential.user);
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message!;
        _showMyDialog("Sign In Error", error.toString(), "Close");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              //height: 100,
              child: Text(
                "Sign In",
                style: TextStyle(color: Colors.blue, fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: _controllerEmail,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              controller: _controllerPassword,
              decoration: const InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock_outline_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                loginUser();
              },
              child: const Text("Log In"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => SignUpPage(
                          onSignUp: widget.onSignIn,
                        )),
                  ),
                );
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
