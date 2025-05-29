import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  final String vendorId;
  final String name;
  final String email;
  final String address;
  final String phone;
  final String contactPerson;
  final double openingBalance;
  final double balanceAmount;

  final String addedById;
  final String addedByName;
  final DateTime? addedOn;

  final String? editedById;
  final String? editedByName;
  final DateTime? editedOn;

  VendorModel({
    required this.vendorId,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.contactPerson,
    required this.openingBalance,
    required this.balanceAmount,
    required this.addedById,
    required this.addedByName,
    this.addedOn,
    this.editedById,
    this.editedByName,
    this.editedOn,
  });

  Map<String, dynamic> toJson() {
    return {
      'VENDOR_ID': vendorId,
      'NAME': name,
      'EMAIL': email,
      'ADDRESS': address,
      'PHONE': phone,
      'CONTACT_PERSON': contactPerson,
      'OPENING_BALANCE': openingBalance,
      'BALANCE_AMOUNT': balanceAmount,
      'ADDED_BY_ID': addedById,
      'ADDED_BY_NAME': addedByName,
      'ADDED_ON': addedOn,
      'EDITED_BY_ID': editedById,
      'EDITED_BY_NAME': editedByName,
      'EDITED_ON': editedOn,
    };
  }

  factory VendorModel.from(Map<String, dynamic> data) {
    return VendorModel(
      vendorId: data['VENDOR_ID'] ?? '',
      name: data['NAME'] ?? '',
      email: data['EMAIL'] ?? '',
      address: data['ADDRESS'] ?? '',
      phone: data['PHONE'] ?? '',
      contactPerson: data['CONTACT_PERSON'] ?? '',
      openingBalance: (data['OPENING_BALANCE'] ?? 0).toDouble(),
      balanceAmount: (data['BALANCE_AMOUNT'] ?? 0).toDouble(),
      addedById: data['ADDED_BY_ID'] ?? '',
      addedByName: data['ADDED_BY_NAME'] ?? '',
      addedOn: data['ADDED_ON'] is Timestamp
              ? (data['ADDED_ON'] as Timestamp).toDate()
              : data['ADDED_ON'] is DateTime
              ? data['ADDED_ON']
              : null,
      editedById: data['EDITED_BY_ID'],
      editedByName: data['EDITED_BY_NAME'],
      editedOn: data['EDITED_ON'] is Timestamp
              ? (data['EDITED_ON'] as Timestamp).toDate()
              : data['EDITED_ON'] is DateTime
              ? data['EDITED_ON']
              : null,
    );
  }
}
