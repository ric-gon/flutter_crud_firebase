import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ItemView extends StatefulWidget {
  final String email;
  final String firstName;

  // ignore: use_key_in_widget_constructors
  const ItemView({required this.email, required this.firstName});
  
  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update User"),
        actions: [
          IconButton(
            // ignore: avoid_print
            onPressed: () => print("delete"),
            icon: const Icon(Icons.delete_outline_outlined),
            color: Colors.white,
          )
        ],
      ),
      body: Center(
        //Widget que contiene todo el form incluyendo los botones
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              //height: 100,
              child: Text("error"),
            ),
            TextFormField(
              controller: _controllerEmail..text = widget.email,
              decoration: const InputDecoration(
                labelText: "Id",
              ),
            ),
            TextFormField(
              controller: _controllerPassword..text = widget.firstName,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),
          ]
        )
      )
    );
  }
}
