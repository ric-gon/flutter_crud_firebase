import 'package:flutter/material.dart';
import 'package:armirene_colombia_sas/controllers/views_controller.dart';
import 'package:armirene_colombia_sas/widgets/create_item_form.dart';

class TestPage extends StatefulWidget {
const TestPage({ Key? key }) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
   
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Item"),
        actions: [
          IconButton(
            onPressed: () {
                  setState(() {
                    Navigator.pop(context, MaterialPageRoute(builder: (context)=> ViewsController()));
                  });
                },
            icon: const Icon(Icons.delete_outline_outlined),
            color: Colors.white,
          )
        ],
      ),
      body: CreateItemForm(),
    );
  }
}