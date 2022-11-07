import 'package:armirene_colombia_sas/pages/new_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';
import 'item_view.dart';
import 'test_page.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  final Function(User?) onSignOut;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  HomePage({required this.onSignOut});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> collectionField = [
    "firstSurname",
    "secondSurname",
    "firstName",
    "otherNames",
    "country",
    "idType",
    "id",
    "email",
    "lastActivity",
    "vertical",
    "dateCreated",
  ];
  String fieldSelected = "email";
  List<String> orderBy = ["Ascending", "Descending"];
  String isDescending = "Descending";

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
                      )),
                ),
              );
            },
            icon: const Icon(Icons.settings),
            color: Colors.white,
          ),
        ),
        title: Text(item.email),
        subtitle: Text(item.id),
      );

  Stream<List<Item>> readUsers() => FirebaseFirestore.instance
      .collection('items')
      .orderBy(
        fieldSelected,
        descending: isDescending == "Descending" ? true : false,
      )
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
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TestPage()));
            },
            icon: const Icon(Icons.error_outline_sharp),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 15),
              const Text('Select field: '),
              DropdownButton<String>(
                value: fieldSelected,
                items: collectionField.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    onTap: () {
                      setState(() {
                        fieldSelected = value;
                      });
                    },
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 15),
              const Text('Select order: '),
              DropdownButton<String>(
                value: isDescending,
                items: orderBy.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    onTap: () {
                      setState(() {
                        isDescending = value;
                      });
                    },
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ],
          ),
          StreamBuilder(
            stream: readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                final items = snapshot.data!;
                return ListView(
                    shrinkWrap: true, children: items.map(buildUser).toList());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
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
