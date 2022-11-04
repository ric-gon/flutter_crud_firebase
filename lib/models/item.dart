class Item {
  String firstSurname;
  String secondSurname;
  String firstName;
  String otherNames;
  String country;
  String idType;
  String id;
  String email;
  String lastActivity;
  String vertical;
  String dateCreated;

  Item(
    this.firstSurname,
    this.secondSurname,
    this.firstName,
    this.otherNames,
    this.country,
    this.idType,
    this.id,
    this.email,
    this.lastActivity,
    this.vertical,
    this.dateCreated,
  );

  Map<String, dynamic> toJson() => {
        'firstSurname': firstSurname,
        'secondSurname': secondSurname,
        'firstName': firstName,
        'otherNames': otherNames,
        'country': country,
        'idType': idType,
        'id': id,
        'email': email,
        'lastActivity': lastActivity,
        'vertical': vertical,
        'dateCreated': dateCreated,
      };

  static Item fromJson(Map<String, dynamic> json) => Item(
        json['firstSurname'],
        json['secondSurname'],
        json['firstName'],
        json['otherNames'],
        json['country'],
        json['idType'],
        json['id'],
        json['email'],
        json['lastActivity'],
        json['vertical'],
        json['dateCreated'],
      );
}
