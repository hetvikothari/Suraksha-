class EmergencyContact {
  String email;
  String name;
  String phoneno;

  EmergencyContact(
      {required this.email, required this.name, required this.phoneno});

  factory EmergencyContact.fromMap(Map<String, String> json) {
    EmergencyContact newUser = EmergencyContact(
        email: json['email'].toString(),
        name: json['name'].toString(),
        phoneno: json['phoneno'].toString());
    return newUser;
  }

  Map toJson() => {'email': email, 'name': name, 'phoneno': phoneno};
}
