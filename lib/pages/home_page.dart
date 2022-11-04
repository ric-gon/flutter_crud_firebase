import 'package:armirene_colombia_sas/pages/new_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';
import 'item_view.dart';

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

  Widget buildUser(Item item) => ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black54,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => ItemView(
                    item: item,
                        /* firstSurname: item.firstSurname.toString(),
                        secondSurname: item.secondSurname.toString(),
                        firstName: item.firstName.toString(),
                        otherNames: item.otherNames.toString(),
                        country: item.country.toString(),
                        idType: item.idType.toString(),
                        id: item.id.toString(),
                        email: item.email.toString(),
                        lastActivity: item.lastActivity.toString(),
                        vertical: item.vertical.toString(),
                        dateCreated: item.dateCreated.toString(), */
                      )),
                ),
              );
            },
            icon: const Icon(Icons.settings),
            color: Colors.white,
          ),
        ),
        title: Text(item.email),
        subtitle: Text(item.firstName),
      );

  Stream<List<Item>> readUsers() => FirebaseFirestore.instance
      .collection('items')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());

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
            final items = snapshot.data!;
            return ListView(children: items.map(buildUser).toList());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        // ignore: avoid_print
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewItem()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
