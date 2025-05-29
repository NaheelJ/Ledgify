import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String surName;
  final String phone;
  final String email;
  final String password;
  final String addedById;
  final DateTime? addedOn;
  final String addedByName;
  final String role;
  final String? editedById;
  final String? editedByName;
  final DateTime? editedOn;
  final String status;

  UserModel({
    required this.userId,
    required this.name,
    required this.surName,
    required this.phone,
    required this.email,
    required this.password,
    required this.addedById,
    this.addedOn,
    required this.addedByName,
    required this.role,
    this.editedById,
    this.editedByName,
    this.editedOn,
    this.status = 'Active',
  });

  Map<String, dynamic> toJson() {
    return {
      'USER_ID': userId,
      'NAME': name,
      'SUR_NAME': surName,
      'PHONE': phone,
      'EMAIL': email,
      'PASSWORD': password,
      'ADDED_BY_ID': addedById,
      'ADDED_ON': addedOn != null ? Timestamp.fromDate(addedOn!) : null,
      'ADDED_BY_NAME': addedByName,
      'ROLE': role,
      'EDITED_BY_ID': editedById,
      'EDITED_BY_NAME': editedByName,
      'EDITED_ON': editedOn != null ? Timestamp.fromDate(editedOn!) : null,
      'STATUS': status,
    };
  }

  factory UserModel.from(Map<String, dynamic> data) {
    return UserModel(
      userId: data['USER_ID'] ?? '',
      name: data['NAME'] ?? '',
      surName: data['SUR_NAME'] ?? '',
      phone: data['PHONE'] ?? '',
      email: data['EMAIL'] ?? '',
      password: data['PASSWORD'] ?? '',
      addedById: data['ADDED_BY_ID'] ?? '',
      addedOn: data['ADDED_ON'] != null ? (data['ADDED_ON'] as Timestamp).toDate() : null,
      addedByName: data['ADDED_BY_NAME'] ?? '',
      role: data['ROLE'] ?? '',
      editedById: data['EDITED_BY_ID'],
      editedByName: data['EDITED_BY_NAME'],
      editedOn: data['EDITED_ON'] != null ? (data['EDITED_ON'] as Timestamp).toDate() : null,
      status: data['STATUS'] ?? 'Active',
    );
  }
}
