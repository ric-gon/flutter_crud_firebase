import 'package:cloud_firestore/cloud_firestore.dart';

class User1 {
  String id;
  String name;

  User1(this.name, this.id);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  static User1 fromJson(Map<String, dynamic> json) =>
      User1(json['name'], json['id']);

  
}
