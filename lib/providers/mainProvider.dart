import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../constants/myColors.dart';

class MainProvider with ChangeNotifier {
int selectedIndex = 0;
int? expandedTileIndex;

void setSelectedIndex(int index) {
  selectedIndex = index;
  notifyListeners();
}

void setExpandedTileIndex(int? index) {
  expandedTileIndex = index;
  notifyListeners();
}

final FocusNode focusNode = FocusNode();
final FocusNode amountFocusNode = FocusNode();
final FocusNode invoiceFocusNode = FocusNode();
final FocusNode invoiceDateFocusNode = FocusNode();
final FocusNode billAmountFocusNode = FocusNode();
final FocusNode paidAmountFocusNode = FocusNode();

Color _borderColor = clD5D7DA;

Color get borderColor => _borderColor;

TextFieldFocusProvider() {
  focusNode.addListener(_onFocusChange);
}

void _onFocusChange() {
  _borderColor = focusNode.hasFocus ? Colors.orange : Colors.grey;
  notifyListeners();
}

@override
void dispose() {
  amountFocusNode.dispose();
  invoiceFocusNode.dispose();
  invoiceDateFocusNode.dispose();
  billAmountFocusNode.dispose();
  paidAmountFocusNode.dispose();
  super.dispose();
}


/// purchase records
String _priority = 'Priority';
String _payable = 'Payable';

String get priority => _priority;
String get payable => _payable;

void setPriority(String value) {
  _priority = value;
  notifyListeners();
}

void setPayable(String value) {
  _payable = value;
  notifyListeners();
}

// date
  DateTime? _invoiceDate;

  DateTime? get invoiceDate => _invoiceDate;

  void setInvoiceDate(DateTime date) {
    _invoiceDate = date;
    notifyListeners();
  }
   DateTime? _dueDate;

  DateTime? get dueDate => _dueDate;

  void setDueDate(DateTime date) {
    _dueDate = date;
    notifyListeners();
  }

// daybook
 DateTime? _dayBookDate;

  DateTime? get dayBookDate => _dayBookDate;

  void setdayBook(DateTime date) {
    _dayBookDate = date;
    notifyListeners();
  }

  String _ledger = 'Select Ledger';
  String _account = 'Select Account';

  String get ledger => _ledger;
  String get account => _account;

  void setLedger(String value) {
    _ledger = value;
    notifyListeners();
  }

  void setAccount(String value) {
    _account = value;
    notifyListeners();
  }

// ledger

  String _type = 'Select Type';

  String get type => _type;

  void setType(String value) {
    _type = value;
    notifyListeners();
  }


  // internal transfer

  DateTime? _internalTransferDate;

  DateTime? get internalTransferDate => _internalTransferDate;

  void setInternalTransferDate(DateTime date) {
    _internalTransferDate = date;
    notifyListeners();
  }


  String _sourceAccount = 'Source Account';

  String get sourceAccount => _sourceAccount;

  void setSourceAccount(String value) {
    _sourceAccount = value;
    notifyListeners();
  }
  String _desigAccount = 'Destination Account';
  String get desigAccount => _desigAccount;


  void setDesignAccount(String value) {
    _desigAccount = value;
    notifyListeners();
  }


}
