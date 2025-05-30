import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
  String companyId;
  String companyName;
  String email;
  String address;
  String phone;
  String taxId;
  String status;

  // Metadata
  String addedById;
  String addedByName;
  DateTime? addedOn;

  String? editedById;
  String? editedByName;
  DateTime? editedOn;

  CompanyModel({
    required this.companyId,
    required this.companyName,
    required this.email,
    required this.address,
    required this.phone,
    required this.taxId,
    required this.status,
    required this.addedById,
    required this.addedByName,
    this.addedOn,
    this.editedById,
    this.editedByName,
    this.editedOn,
  });

  Map<String, dynamic> toJson() {
    return {
      'COMPANY_ID': companyId,
      'COMPANY_NAME': companyName,
      'EMAIL': email,
      'ADDRESS': address,
      'PHONE': phone,
      'TAX_ID': taxId,
      'STATUS': status,
      'ADDED_BY_ID': addedById,
      'ADDED_BY_NAME': addedByName,
      'ADDED_ON': addedOn,
      'EDITED_BY_ID': editedById,
      'EDITED_BY_NAME': editedByName,
      'EDITED_ON': editedOn,
    };
  }

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      companyId: json['COMPANY_ID']?.toString() ?? '',
      companyName: json['COMPANY_NAME']?.toString() ?? '',
      email: json['EMAIL']?.toString() ?? '',
      address: json['ADDRESS']?.toString() ?? '',
      phone: json['PHONE']?.toString() ?? '',
      taxId: json['TAX_ID']?.toString() ?? '',
      status: json['STATUS']?.toString() ?? '',
      addedById: json['ADDED_BY_ID']?.toString() ?? '',
      addedByName: json['ADDED_BY_NAME']?.toString() ?? '',
      addedOn:
          json['ADDED_ON'] is Timestamp
              ? (json['ADDED_ON'] as Timestamp).toDate()
              : json['ADDED_ON'] is DateTime
              ? json['ADDED_ON']
              : null,
      editedById: json['EDITED_BY_ID']?.toString(),
      editedByName: json['EDITED_BY_NAME']?.toString(),
      editedOn:
          json['EDITED_ON'] is Timestamp
              ? (json['EDITED_ON'] as Timestamp).toDate()
              : json['EDITED_ON'] is DateTime
              ? json['EDITED_ON']
              : null,
    );
  }
}
