import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatelessWidget {
  final Function(User?) onSignOut;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  HomePage({required this.onSignOut});

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    onSignOut(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: const Icon(Icons.logout),
          ),
          /*AlertDialog(
            title: Text("Log Out?"),
            content: Text("Do you Log Out?"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.check),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.close),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}
