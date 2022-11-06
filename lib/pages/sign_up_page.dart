import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:armirene_colombia_sas/controllers/views_controller.dart';
import 'package:armirene_colombia_sas/widgets/custom_alert_dialog.dart';

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

  Future<void> _showMyDialog(txt1, txt2, txtBttn1) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (_) => CustomAlertDialog(text1: txt1, text2: txt2, textButton1: txtBttn1));
  }

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
        _showMyDialog("Sign Up Error", error.toString(), "Close");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              //height: 100,
              child: Text("Create an account!", style: TextStyle(color: Colors.blue, fontSize: 30),),
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
            ),const SizedBox(
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
