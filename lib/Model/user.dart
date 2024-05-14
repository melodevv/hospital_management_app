class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? id;
  String? idNr;
  String? contactNr;
  String? dateOfBirth;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.id,
    this.idNr,
    this.contactNr,
    this.dateOfBirth,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    idNr = json['idNr'];
    id = json['id'];
    contactNr = json['contactNr'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['idNr'] = idNr;
    data['contactNr'] = contactNr;
    data['id'] = id;
    data['dateOfBirth'] = dateOfBirth;
    return data;
  }
}
