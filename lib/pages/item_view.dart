import 'package:armirene_colombia_sas/widgets/custom_alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:armirene_colombia_sas/models/item.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class ItemView extends StatefulWidget {
  Item item;
  // ignore: use_key_in_widget_constructors
  ItemView({required this.item});
  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  final _formKey = GlobalKey<FormState>(); //Form Key
  String error = ""; // Error varaible message in try catch
  static const List<String> countriesList = ['Colombia', 'United States'];
  static const List<String> idTypeList = [
    'Cédula de Ciudadanía',
    'Cédula de Extranjería',
    'Pasaporte',
    'Permiso Especial'
  ];
  static const List<String> verticalsList = [
    'Administración',
    'Financiera',
    'Compras',
    'Infraestructura',
    'Operación',
    'TalentoHumano',
    'Servicios Varios',
    'etc.'
  ];
  String _country = countriesList.first;
  String _idType = idTypeList.first;
  String _vertical = verticalsList.first;
  final _firstSurname = TextEditingController();
  final _secondSurname = TextEditingController();
  final _firstName = TextEditingController();
  final _otherNames = TextEditingController();
  final _id = TextEditingController();
  final _email = TextEditingController();
  String _dateCreated = DateTime.now().toString();
  DateTime _lastActivity = DateTime.now();

  updateItem() {
    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      FirebaseFirestore.instance
          .collection('items')
          .doc(widget.item.email.toString())
          .update({
        'firstSurname': _firstSurname.text.toString(),
        'secondSurname': _secondSurname.text.toString(),
        'firstName': _firstName.text.toString(),
        'otherNames': _otherNames.text.toString(),
        'country': _country,
        'idType': _idType,
        'id': _id.text.toString(),
        'email': _email.text.toString(),
        'lastActivity': dateFormat.format(_lastActivity),
        'vertical': _vertical,
        'dateCreated': _dateCreated.toString(),
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message!;
      });
    }
  }

  deleteItem() {
    try {
      FirebaseFirestore.instance
          .collection('items')
          .doc(widget.item.email.toString())
          .delete();
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message!;
      });
    }
  }

  //Function that fires the Alert Dialog when any field is not valid in the form
  Future<void> _showMyDialog(txt1, txt2, txtBttn1) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (_) =>
            CustomAlertDialog(text1: txt1, text2: txt2, textButton1: txtBttn1));
  }

  //the next 3 functions validates the fields size, regex and not null values
  String? validateName(String? name) {
    String pattern = r"^[a-zA-Z]";
    RegExp regex = RegExp(pattern);
    if (name == null ||
        name.isEmpty ||
        !(regex.hasMatch(name)) ||
        name.length > 20) {
      return 'Enter a valid name';
    } else {
      return null;
    }
  }

  String? validateOtherName(String? name) {
    String pattern = r"^[a-zA-Z]";
    RegExp regex = RegExp(pattern);
    if (name == null ||
        name.isEmpty ||
        regex.hasMatch(name) ||
        name.length > 50) {
      return null;
    } else {
      return 'Enter a valid name';
    }
  }

  String? validateID(String? id) {
    String pattern = r"^[a-zA-Z0-9-]";
    RegExp regex = RegExp(pattern);
    if (id == null || id.isEmpty || !regex.hasMatch(id)) {
      return 'Enter a valid name';
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _firstSurname.text = widget.item.firstSurname;
    _secondSurname.text = widget.item.secondSurname;
    _firstName.text = widget.item.firstName;
    _otherNames.text = widget.item.otherNames;
    _id.text = widget.item.id;
    _email.text = widget.item.email;
    _country = widget.item.country;
    _idType = widget.item.idType;
    _vertical = widget.item.vertical;
    _dateCreated = widget.item.dateCreated;

    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    _lastActivity = dateFormat.parse(widget.item.lastActivity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update/Delete Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => validateName(value),
                  controller: _firstSurname,
                  decoration: const InputDecoration(
                    suffixIcon: Tooltip(
                      message: "(ñ) is not acepted and max size is 20 letters",
                      child: Icon(Icons.info_outline),
                    ),
                    prefixIcon: Icon(Icons.person),
                    labelText: "First Surname",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => validateName(value),
                  controller: _secondSurname,
                  decoration: const InputDecoration(
                    suffixIcon: Tooltip(
                      message: "(ñ) is not acepted and max size is 20 letters",
                      child: Icon(Icons.info_outline),
                    ),
                    prefixIcon: Icon(Icons.person),
                    labelText: "Second Surname",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => validateName(value),
                  controller: _firstName,
                  decoration: const InputDecoration(
                    suffixIcon: Tooltip(
                      message: "(ñ) is not acepted and max size is 20 letters",
                      child: Icon(Icons.info_outline),
                    ),
                    prefixIcon: Icon(Icons.person),
                    labelText: "First Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => validateOtherName(value),
                  controller: _otherNames,
                  decoration: const InputDecoration(
                    suffixIcon: Tooltip(
                      message:
                          "[Optional field] (ñ) is not acepted and max size is 50 letters",
                      child: Icon(Icons.info_outline),
                    ),
                    prefixIcon: Icon(Icons.person),
                    labelText: "Other Names",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  value: _country,
                  items: countriesList
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _country = value!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  value: _idType,
                  items: idTypeList
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _idType = value!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => validateID(value),
                  controller: _id,
                  decoration: const InputDecoration(
                    suffixIcon: Tooltip(
                      message: "This value must be unique",
                      child: Icon(Icons.info_outline),
                    ),
                    prefixIcon: Icon(Icons.person),
                    labelText: "ID",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  readOnly: true,
                  controller: _email,
                  decoration: const InputDecoration(
                    suffixIcon: Tooltip(
                      message: "Auto-generated field",
                      child: Icon(Icons.info_outline),
                    ),
                    prefixIcon: Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.black12,
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InputDatePickerFormField(
                    fieldLabelText: "Last Activity Date",
                    initialDate: _lastActivity,
                    onDateSubmitted: (value) => _lastActivity = value,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 31)),
                    lastDate: DateTime.now(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  value: _vertical,
                  items: verticalsList
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _vertical = value!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  readOnly: true,
                  controller: TextEditingController()..text = _dateCreated,
                  decoration: const InputDecoration(
                    suffixIcon: Tooltip(
                      message: "Auto-generated field",
                      child: Icon(Icons.info_outline),
                    ),
                    prefixIcon: Icon(Icons.calendar_month),
                    labelText: "Date Created",
                    filled: true,
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState!.validate()) {
                        _showMyDialog(
                            "Item Updated",
                            "The${_email.text.toString().toLowerCase()} item was updated",
                            "Home");
                        updateItem();
                      } else {
                        _showMyDialog("Error", "Invalid values", "Close");
                      }
                    });
                  },
                  child: const Text("Update Item"),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: CircleAvatar(
        backgroundColor: Colors.red,
        child: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Item'),
                content: const Text('Do you want delte this Item?'),
                actions: [
                  TextButton(
                      onPressed: (() {
                        Navigator.of(context).pop();
                      }),
                      child: const Text('Back')),
                  TextButton(
                      onPressed: (() {
                        deleteItem();
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }),
                      child: const Text('Delete Item'))
                ],
              ),
            );
          },
          icon: const Icon(Icons.delete_outline_outlined),
          color: Colors.white,
        ),
      ),
    );
  }
}
