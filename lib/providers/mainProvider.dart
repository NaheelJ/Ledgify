import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  createJournalNode.dispose();
  super.dispose();
}

final FocusNode createJournalNode = FocusNode();

TextFieldJornalFocusProvider() {
  createJournalNode.addListener(_onFocusChange);
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


  /// add purchase


  String _selectedCurrency = 'zł';

  String get selectedCurrency => _selectedCurrency;

  void setCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners(); // Triggers UI rebuild
  }

  // Add other properties like focusNode and borderColor
  final FocusNode billAmount2FocusNode = FocusNode();
  final Color borderColor2 = Colors.grey;


  // date
  TextEditingController dueDateController = TextEditingController();

  DateTime? _invoiceAddDate;

  DateTime? get invoiceAddDate => _invoiceAddDate;

  void setInvoiceAddDate(DateTime date) {
    _invoiceAddDate = date;
    notifyListeners();
  }
  DateTime? _dueAddDate;

  DateTime? get dueAddDate => _dueAddDate;

  void setDueAddDate(DateTime date) {
    _dueDate = date;
    notifyListeners();
  }

  //

  File? _invoiceImage;
  File? get invoiceImage => _invoiceImage;

  void setImageInInvoiceImage(File image) {
    _invoiceImage = image;
    notifyListeners();
  }

  void clearImageInInvoiceImage() {
    _invoiceImage = null;
    notifyListeners();
  }

  void showImagePicker(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt,color: cl8F1A3F,),
                title: const Text('Take Photo'),
                onTap: () async {
                  final XFile? picked =
                  await picker.pickImage(source: ImageSource.camera);
                  if (picked != null) {
                  /*  if(from=='expatriateIssueReporting'){
                      setImageInExpatriateIssueReporting(File(picked.path));
                    }else if(from=='generalIssueReporting'){
                      setImage(File(picked.path));
                    }else if(from=='adminUploadImage'){
                      setImageInUploadImage(File(picked.path));
                    }*/
                    setImageInInvoiceImage(File(picked.path));

                  }
                  Navigator.of(bottomSheetContext).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library,color: cl8F1A3F,),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  final XFile? picked =
                  await picker.pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    /*if(from=='expatriateIssueReporting'){
                      setImageInExpatriateIssueReporting(File(picked.path));
                    }else if(from=='generalIssueReporting'){
                      setImage(File(picked.path));
                    }else if(from=='adminUploadImage'){
                      setImageInUploadImage(File(picked.path));
                    }*/
                    setImageInInvoiceImage(File(picked.path));
                  }
                  Navigator.of(bottomSheetContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

// sales records date

  DateTime? _invoiceSalesDate;

  DateTime? get invoiceSalesDate => _invoiceSalesDate;

  void setInvoiceSalesDate(DateTime date) {
    _invoiceSalesDate = date;
    notifyListeners();
  }
  DateTime? _dueSalesDate;

  DateTime? get dueSalesDate => _dueSalesDate;

  void setDueSalesDate(DateTime date) {
    _dueSalesDate = date;
    notifyListeners();
  }

  String _receivables= 'Receivables';

  String get receivables => _receivables;

  void setReceivables(String value) {
    _receivables = value;
    notifyListeners();
  }

// dash Board Expense chart

  final List<Expense> _expenses = [
    Expense(category: 'Purchase', amount: 980254),
    Expense(category: 'Travel', amount: 730684),
    Expense(category: 'Salary', amount: 720684),
    Expense(category: 'Rent', amount: 685754),
    Expense(category: 'Utilities', amount: 590254),
    Expense(category: 'Taxes', amount: 580999),
    Expense(category: 'Maintenance', amount: 305999),
    Expense(category: 'Advertising', amount: 304875),
    Expense(category: 'Services', amount: 300875),
  ];

  List<Expense> get expenses => _expenses;

  double get totalExpenses => _expenses.fold(0, (sum, expense) => sum + expense.amount);

  // This calculates the maximum Y value for the chart based on the highest expense
  double get maxExpenseValue {
    final maxAmount = _expenses.map((e) => e.amount).reduce((a, b) => a > b ? a : b);
    // Convert to "L" units as shown in chart and round up to nearest 1.5L increment
    return ((maxAmount / 100000) / 1.5).ceil() * 1.5;
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void updateExpense(int index, Expense expense) {
    if (index >= 0 && index < _expenses.length) {
      _expenses[index] = expense;
      notifyListeners();
    }
  }

  void removeExpense(int index) {
    if (index >= 0 && index < _expenses.length) {
      _expenses.removeAt(index);
      notifyListeners();
    }
  }

  final focusName = FocusNode();
  final focusContact = FocusNode();
  final focusEmail = FocusNode();
  final focusBilling = FocusNode();
  final focusPerson = FocusNode();
  final focusTax = FocusNode();
  final focusOpening = FocusNode();

  final focusName1 = FocusNode();
  final focusContact1 = FocusNode();
  final focusEmail1 = FocusNode();
  final focusSurname = FocusNode();
  final focusRole = FocusNode();
  final focusEmployee = FocusNode();
  final focusPesel = FocusNode();
  final focusPassPort = FocusNode();
  // add company
   final focusCompanyName = FocusNode();
  final focusCompanyEmail = FocusNode();
  final focusCompanyContact = FocusNode();
  final focusCompanyAddress = FocusNode();
  final focusCompanyTaxId = FocusNode();

  void disposeFocusNodes() {
    focusName.dispose();
    focusContact.dispose();
    focusEmail.dispose();
    focusBilling.dispose();
    focusPerson.dispose();
    focusTax.dispose();
    focusOpening.dispose();

    focusName1.dispose();
    focusSurname.dispose();
    focusContact1.dispose();
    focusEmail1.dispose();
    focusRole.dispose();
    focusEmployee.dispose();
    focusPesel.dispose();
    focusPassPort.dispose();
    // add company
    focusCompanyName.dispose();
    focusCompanyEmail.dispose();
    focusCompanyContact.dispose();
    focusCompanyAddress.dispose();
    focusCompanyTaxId.dispose();
  }



  DateTime? _payRollDate;
  DateTime? get payRollDate => _payRollDate;

  void setPayRollDate(DateTime date) {
    _payRollDate = date;
    notifyListeners();
  }



  DateTime? _invoiceSalesDate1;

  DateTime? get invoiceSalesDate1=> _invoiceSalesDate1;

  void setInvoiceSalesDate1(DateTime date) {
    _invoiceSalesDate1 = date;
    notifyListeners();
  }
  DateTime? _dueSalesDate1;

  DateTime? get dueSalesDate1 => _dueSalesDate1;

  void setDueSalesDate1(DateTime date) {
    _dueSalesDate1 = date;
    notifyListeners();
  }

  String _company= 'Company A';

  String get company => _company;

  void setCompany(String value) {
    _company = value;
    notifyListeners();
  }


  // upload excel

  File? _selectedFile;

  File? get selectedFile => _selectedFile;

  Future<void> pickExcelFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xls', 'xlsx'],
      withData: false,
    );

    if (result != null && result.files.isNotEmpty && result.files.single.path != null) {
      _selectedFile = File(result.files.single.path!);
      notifyListeners();
    }
  }

  void clearFile() {
    _selectedFile = null;
    notifyListeners();
  }
  void clearFile1() {
    _selectedFile = null;
    notifyListeners();
  }


  String _company1= 'Company A';

  String get company1 => _company1;

  void setCompany1(String value) {
    _company1 = value;
    notifyListeners();
  }

  String _ledger1= 'Krakow Electronics';

  String get ledger1 => _ledger1;

  void setLedger1(String value) {
    _ledger1 = value;
    notifyListeners();
  }

  String _group= 'Purchase';

  String get group => _group;

  void setGroup(String value) {
    _group = value;
    notifyListeners();
  }


  DateTime? _expenseDate;

  DateTime? get expenseDate=> _expenseDate;

  void setExpenseDate(DateTime date) {
    _expenseDate = date;
    notifyListeners();
  }


}




class Expense {
  final String category;
  final double amount;

  Expense({required this.category, required this.amount});
}