import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:armirene_colombia_sas/views_controller.dart';
import 'package:armirene_colombia_sas/models/item.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class ItemView extends StatefulWidget {
  
  Item item;
  // ignore: use_key_in_widget_constructors
  ItemView({required this.item});
  /*String firstSurname,
      secondSurname,
      firstName,
      otherNames,
      country,
      idType,
      id,
      email,
      lastActivity,
      vertical,
      dateCreated;

  // ignore: use_key_in_widget_constructors
  ItemView(
      {required this.firstSurname,
      required this.secondSurname,
      required this.firstName,
      required this.otherNames,
      required this.country,
      required this.idType,
      required this.id,
      required this.email,
      required this.lastActivity,
      required this.vertical,
      required this.dateCreated});*/

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
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
  String error='';

  updateItem() {
    try {
      FirebaseFirestore.instance.collection('items').doc(widget.item.email.toString()).update({
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
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message!;
      });
    }
  }

  deleteItem() {
    try {
      FirebaseFirestore.instance.collection('items').doc(widget.item.email.toString()).delete();
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
        title: const Text("Update Item"),
        actions: [
          IconButton(
            // ignore: avoid_print
            onPressed: () {
                  setState(() {
                    deleteItem();
                    Navigator.pop(context, MaterialPageRoute(builder: (context)=> ViewsController()));
                  });
                },
            icon: const Icon(Icons.delete_outline_outlined),
            color: Colors.white,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          //Widget que contiene todo el form incluyendo los botones
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                //height: 100,
                child: Text("These are the values of the selected Item:"),
              ),
              TextFormField(
                controller: _firstSurname..text = widget.item.firstSurname,
                decoration: const InputDecoration(labelText: "First Surname"),
              ),
              TextFormField(
                controller: _secondSurname..text = widget.item.secondSurname,
                decoration: const InputDecoration(labelText: "Second Surname"),
              ),
              TextFormField(
                controller: _firstName..text = widget.item.firstName,
                decoration: const InputDecoration(labelText: "First Name"),
              ),
              TextFormField(
                controller: _otherNames..text = widget.item.otherNames,
                decoration: const InputDecoration(labelText: "Other Names"),
              ),
              TextFormField(
                controller: _country..text = widget.item.country,
                decoration: const InputDecoration(labelText: "Country"),
              ),
              TextFormField(
                controller: _idType..text = widget.item.idType,
                decoration: const InputDecoration(labelText: "ID Type"),
              ),
              TextFormField(
                controller: _id..text = widget.item.id,
                decoration: const InputDecoration(labelText: "ID"),
              ),
              TextFormField(
                controller: _email..text = widget.item.email,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                controller: _lastActivity..text = widget.item.lastActivity,
                decoration: const InputDecoration(labelText: "Last Activity"),
              ),
              TextFormField(
                controller: _vertical..text = widget.item.vertical,
                decoration: const InputDecoration(labelText: "Vertical"),
              ),
              TextFormField(
                controller: _dateCreated..text = widget.item.dateCreated,
                decoration: const InputDecoration(labelText: "Date Created"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    updateItem();
                    Navigator.pop(context, MaterialPageRoute(builder: (context)=> ViewsController()));
                  });
                },
                child: const Text("Update Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
