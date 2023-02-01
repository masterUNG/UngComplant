import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String email;
  final String password;
  final String gendle;
  final String name;
  final String surname;
  final bool? admin;
  UserModel({
    required this.email,
    required this.password,
    required this.gendle,
    required this.name,
    required this.surname,
    this.admin,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'gendle': gendle,
      'name': name,
      'surname': surname,
      'admin': admin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      gendle: (map['gendle'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      surname: (map['surname'] ?? '') as String,
      admin: map['admin'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
