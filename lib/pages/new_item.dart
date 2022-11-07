import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../widgets/custom_alert_dialog.dart';

// ignore: use_key_in_widget_constructors
class NewItem extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
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
  static final DateTime _dateCreated = DateTime.now();
  final _lastActivity = DateTime.now();

  // String to format the Date Created field
  String convertedDateTime =
      "${_dateCreated.day.toString().padLeft(2, '0')}/${_dateCreated.month.toString().padLeft(2, '0')}/${_dateCreated.year.toString()} ${_dateCreated.hour.toString().padLeft(2, '0')}:${_dateCreated.minute.toString().padLeft(2, '0')}:${_dateCreated.second.toString().padLeft(2, '0')}";

  //Create a new Item in the 'items' collection in Firebase
  Future<void> createItem() async {
    try {
      final docUser = FirebaseFirestore.instance
          .collection('items')
          .doc(_email.text.toString().toLowerCase());

      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

      final json = {
        'firstSurname': _firstSurname.text.toString(),
        'secondSurname': _secondSurname.text.toString(),
        'firstName': _firstName.text.toString(),
        'otherNames': _otherNames.text.toString(),
        'country': _country,
        'idType': _idType,
        'id': _id.text.toString(),
        'email': _email.text.toString().toLowerCase(),
        'lastActivity': dateFormat.format(_lastActivity),
        'vertical': _vertical,
        'dateCreated': _dateCreated.toString(),
      };
      await docUser.set(json);
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
        barrierDismissible: false, // user must tap button!
        builder: (_) =>
            CustomAlertDialog(text1: txt1, text2: txt2, textButton1: txtBttn1));
  }

  //Function where the email is created concatenate the domain array
  List<String> domain = ["", ".", "", "", "@domain.com"];
  updateDomain(textDomain, int position) {
    position == 0 ? domain[0] = textDomain : domain[2] = textDomain;
    return domain;
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Item'),
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
                        message:
                            "(ñ) is not acepted and max size is 20 letters",
                        child: Icon(Icons.info_outline),
                      ),
                      prefixIcon: Icon(Icons.person),
                      labelText: "First Surname",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        updateDomain(value?.toLowerCase(), 0);
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => validateName(value),
                    controller: _secondSurname,
                    decoration: const InputDecoration(
                      suffixIcon: Tooltip(
                        message:
                            "(ñ) is not acepted and max size is 20 letters",
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
                        message:
                            "(ñ) is not acepted and max size is 20 letters",
                        child: Icon(Icons.info_outline),
                      ),
                      prefixIcon: Icon(Icons.person),
                      labelText: "First Name",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        updateDomain(value?.toLowerCase(), 1);
                      });
                    },
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
                    controller: _email..text = domain.join(),
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
                    controller: TextEditingController()
                      ..text = convertedDateTime,
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
                              "New Item",
                              "Your email is ${_email.text.toString().toLowerCase()}",
                              "Home");
                          createItem();
                        } else {
                          _showMyDialog("Error", "Invalid values", "Close");
                        }
                      });
                    },
                    child: const Text("Create Item"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
