import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'models/user1.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  final Function(User?) onSignOut;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  HomePage({required this.onSignOut});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    widget.onSignOut(null);
  }

  Widget buildUser(User1 user) => ListTile(
        title: Text(user.id),
        subtitle: Text(user.name),
      );

  Stream<List<User1>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User1.fromJson(doc.data())).toList());

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
          ],
        ),
        body: StreamBuilder(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              final users = snapshot.data!;

              return ListView(children: users.map(buildUser).toList());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
