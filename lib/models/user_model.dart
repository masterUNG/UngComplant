import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String email;
  final String password;
  final String gendle;
  final String name;
  final String surname;
  UserModel({
    required this.email,
    required this.password,
    required this.gendle,
    required this.name,
    required this.surname,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'gendle': gendle,
      'name': name,
      'surname': surname,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      gendle: (map['gendle'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      surname: (map['surname'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
