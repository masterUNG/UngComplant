// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ComplantModel {
  final String uidComplant;
  final String typeComplant;
  final bool displayWhoComplant;
  final GeoPoint geoPoint;
  final String detail;
  final Timestamp timestamp;
  ComplantModel({
    required this.uidComplant,
    required this.typeComplant,
    required this.displayWhoComplant,
    required this.geoPoint,
    required this.detail,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uidComplant': uidComplant,
      'typeComplant': typeComplant,
      'displayWhoComplant': displayWhoComplant,
      'geoPoint': geoPoint,
      'detail': detail,
      'timestamp': timestamp,
    };
  }

  factory ComplantModel.fromMap(Map<String, dynamic> map) {
    return ComplantModel(
      uidComplant: (map['uidComplant'] ?? '') as String,
      typeComplant: (map['typeComplant'] ?? '') as String,
      displayWhoComplant: (map['displayWhoComplant'] ?? false) as bool,
      geoPoint: (map['geoPoint']),
      detail: (map['detail'] ?? '') as String,
      timestamp:(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplantModel.fromJson(String source) => ComplantModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
