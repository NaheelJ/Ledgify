import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
  String companyId;
  String companyName;
  String email;
  String address;
  String phone;
  String taxId;
  String addedById;
  DateTime? addedOn;
  String addedByName;

  CompanyModel({
    required this.companyId,
    required this.companyName,
    required this.email,
    required this.address,
    required this.phone,
    required this.taxId,
    required this.addedById,
    this.addedOn,
    required this.addedByName,
  });

  // Convert a Company object to a Map (for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'COMPANY_ID': companyId,
      'COMPANY_NAME': companyName,
      'EMAIL': email,
      'ADDRESS': address,
      'PHONE': phone,
      'TAX_ID': taxId,
      'ADDED_BY_ID': addedById,
      'ADDED_ON': addedOn,
      'ADDED_BY_NAME': addedByName,
    };
  }

  // Create a Company object from a Map (for JSON deserialization)
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      companyId: json['COMPANY_ID'] as String,
      companyName: json['COMPANY_NAME'] as String,
      email: json['EMAIL'] as String,
      address: json['ADDRESS'] as String,
      phone: json['PHONE'] as String,
      taxId: json['TAX_ID'] as String,
      addedById: json['ADDED_BY_ID'] as String,
      addedOn: json['ADDED_ON'] != null ? (json['ADDED_ON'] as Timestamp).toDate() : null,
      addedByName: json['ADDED_BY_NAME'] as String,
    );
  }
}
