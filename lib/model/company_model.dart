import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
  final String id;
  final String companyName;
  final String address;
  final String taxId;
  final String email;
  final String contactNumber;
  final DateTime? addedDate;
  final String addedBy;
  final String status;
  final String role;

  CompanyModel({
    required this.id,
    required this.companyName,
    required this.address,
    required this.taxId,
    required this.email,
    required this.contactNumber,
    required this.addedBy,
    required this.status,
    required this.role,
    this.addedDate,
  });

  factory CompanyModel.fromMap(Map<String, dynamic> data) {
    return CompanyModel(
      id: data['ID'] ?? '',
      companyName: data['COMPANY_NAME'] ?? '',
      address: data['ADDRESS'] ?? '',
      taxId: data['TAX_ID'] ?? '',
      email: data['EMAIL'] ?? '',
      contactNumber: data['CONTACT_NUMBER'] ?? '',
      addedDate: data['ADDED_DATE'] != null ? (data['ADDED_DATE'] as Timestamp).toDate() : null,
      addedBy: data['ADDED_BY'] ?? '',
      status: data['STATUS'] ?? '',
      role: data['ROLE'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'COMPANY_NAME': companyName,
      'ADDRESS': address,
      'TAX_ID': taxId,
      'EMAIL': email,
      'CONTACT_NUMBER': contactNumber,
      'ADDED_DATE': addedDate,
      'ADDED_BY': addedBy,
      'STATUS': status,
      'ROLE': role,
    };
  }
}
