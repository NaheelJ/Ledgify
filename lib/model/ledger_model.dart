import 'package:cloud_firestore/cloud_firestore.dart';

class LedgerModel {
  final String ledgerId;
  final String name;
  final double openingBalance;
  final double balanceAmount;
  final String status;

  final String groupName;
  final String groupId;

  final String companyId;
  final String companyName;

  final List<String> keywords;

  final String addedById;
  final String addedByName;
  final DateTime? addedOn;

  final String? editedById;
  final String? editedByName;
  final DateTime? editedOn;

  LedgerModel({
    required this.ledgerId,
    required this.name,
    required this.openingBalance,
    required this.balanceAmount,
    required this.status,
    required this.groupName,
    required this.groupId,
    required this.companyId,
    required this.companyName,
    required this.keywords,
    required this.addedById,
    required this.addedByName,
    this.addedOn,
    this.editedById,
    this.editedByName,
    this.editedOn,
  });

  Map<String, dynamic> toJson() {
    return {
      'LEDGER_ID': ledgerId,
      'NAME': name,
      'OPENING_BALANCE': openingBalance,
      'BALANCE_AMOUNT': balanceAmount,
      'STATUS': status,
      'GROUP_NAME': groupName,
      'GROUP_ID': groupId,
      'COMPANY_ID': companyId,
      'COMPANY_NAME': companyName,
      'KEY_WORDS': keywords,
      'ADDED_BY_ID': addedById,
      'ADDED_BY_NAME': addedByName,
      'ADDED_ON': addedOn,
      'EDITED_BY_ID': editedById,
      'EDITED_BY_NAME': editedByName,
      'EDITED_ON': editedOn,
    };
  }

  factory LedgerModel.from(Map<String, dynamic> data) {
    return LedgerModel(
      ledgerId: data['LEDGER_ID'] ?? '',
      name: data['NAME'] ?? '',
      openingBalance: (data['OPENING_BALANCE'] ?? 0).toDouble(),
      balanceAmount: (data['BALANCE_AMOUNT'] ?? 0).toDouble(),
      status: data['STATUS'] ?? '',
      groupName: data['GROUP_NAME'] ?? '',
      groupId: data['GROUP_ID'] ?? '',
      companyId: data['COMPANY_ID'] ?? '',
      companyName: data['COMPANY_NAME'] ?? '',
      keywords: List<String>.from(data['KEY_WORDS'] ?? []),
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
