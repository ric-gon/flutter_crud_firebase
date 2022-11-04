import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:armirene_colombia_sas/views_controller.dart';

// ignore: use_key_in_widget_constructors
class NewItem extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _firstSurname = TextEditingController();
  final _secondSurname = TextEditingController();
  final _firstName = TextEditingController();
  final _otherNames = TextEditingController();
  final _country = TextEditingController();
  final _idType = TextEditingController();
  final _id = TextEditingController();
  final _email = TextEditingController();
  final _lastActivity = TextEditingController();
  final _vertical = TextEditingController();
  final _dateCreated = TextEditingController();
  String error = "";

  //funcion que asigna un nuevo usuario a la base de datos en Firebase
  Future<void> createItem() async {
    try {
      final docUser = FirebaseFirestore.instance.collection('items').doc(_email.text.toString());
      final json = {
        'firstSurname': _firstSurname.text.toString(),
        'secondSurname': _secondSurname.text.toString(),
        'firstName': _firstName.text.toString(),
        'otherNames': _otherNames.text.toString(),
        'country': _country.text.toString(),
        'idType': _idType.text.toString(),
        'id': _id.text.toString(),
        'email': _email.text.toString(),
        'lastActivity': _lastActivity.text.toString(),
        'vertical': _vertical.text.toString(),
        'dateCreated': _dateCreated.text.toString(),
      };
      await docUser.set(json);
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
        title: const Text('Create Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _firstSurname,
                decoration: const InputDecoration(labelText: "First Surname"),
              ),
              TextFormField(
                controller: _secondSurname,
                decoration: const InputDecoration(labelText: "Second Surname"),
              ),
              TextFormField(
                controller: _firstName,
                decoration: const InputDecoration(labelText: "First Name"),
              ),
              TextFormField(
                controller: _otherNames,
                decoration: const InputDecoration(labelText: "Other Names"),
              ),
              TextFormField(
                controller: _country,
                decoration: const InputDecoration(labelText: "Country"),
              ),
              TextFormField(
                controller: _idType,
                decoration: const InputDecoration(labelText: "ID Type"),
              ),
              TextFormField(
                controller: _id,
                decoration: const InputDecoration(labelText: "ID"),
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                controller: _lastActivity,
                decoration: const InputDecoration(labelText: "Last Activity"),
              ),
              TextFormField(
                controller: _vertical,
                decoration: const InputDecoration(labelText: "Vertical"),
              ),
              TextFormField(
                controller: _dateCreated,
                decoration: const InputDecoration(labelText: "Date Created"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    createItem();
                    Navigator.pop(context, MaterialPageRoute(builder: (context)=> ViewsController()));
                  });
                },
                child: const Text("Create Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
