import 'dart:async' show Completer, StreamSubscription;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ledgifi/model/company_model.dart';

import '../constants/myColors.dart';

class MainProvider with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
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

  ///top bar
  int topBarSelectedIndex = -1;

  ///

  void setPayable(String value) {
    _payable = value;
    notifyListeners();
  }

  void setPriority(String value) {
    _priority = value;
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
                leading: const Icon(Icons.camera_alt, color: cl8F1A3F),
                title: const Text('Take Photo'),
                onTap: () async {
                  final XFile? picked = await picker.pickImage(source: ImageSource.camera);
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
                leading: const Icon(Icons.photo_library, color: cl8F1A3F),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
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

  String _receivables = 'Receivables';

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
  final focusCompanyPassword = FocusNode();

  //invoiceSettlement

  final focusInvoiceNumber = FocusNode();
  final focusBillAmount = FocusNode();
  final focusBalance = FocusNode();
  final focusPaidAmount = FocusNode();
  final focusPaymentDate = FocusNode();

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

    focusInvoiceNumber.dispose();
    focusBillAmount.dispose();
    focusBalance.dispose();
    focusPaidAmount.dispose();
    focusPaymentDate.dispose();
  }

  DateTime? _payRollDate;
  DateTime? get payRollDate => _payRollDate;

  void setPayRollDate(DateTime date) {
    _payRollDate = date;
    notifyListeners();
  }

  DateTime? _invoiceSalesDate1;

  DateTime? get invoiceSalesDate1 => _invoiceSalesDate1;

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

  String _company = 'Company A';

  String get company => _company;

  void setCompany(String value) {
    _company = value;
    notifyListeners();
  }

  // upload excel

  File? _selectedFile;

  File? get selectedFile => _selectedFile;

  Future<void> pickExcelFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xls', 'xlsx'], withData: false);

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

  String _company1 = 'Company A';

  String get company1 => _company1;

  void setCompany1(String value) {
    _company1 = value;
    notifyListeners();
  }

  String _ledger1 = 'Krakow Electronics';

  String get ledger1 => _ledger1;

  void setLedger1(String value) {
    _ledger1 = value;
    notifyListeners();
  }

  String _group = 'Purchase';

  String get group => _group;

  void setGroup(String value) {
    _group = value;
    notifyListeners();
  }

  DateTime? _expenseDate;

  DateTime? get expenseDate => _expenseDate;

  void setExpenseDate(DateTime date) {
    _expenseDate = date;
    notifyListeners();
  }

  // access for users

  String _access = 'Admin';

  String get access => _access;

  void setAccess(String value) {
    _access = value;
    notifyListeners();
  }

  int _selectedYear = 2025;
  String _selectedMonth = 'May';
  double _totalExpenseDate = 0.0; // Assuming this exists based on your usage

  int get selectedYear => _selectedYear;
  String get selectedMonth => _selectedMonth;
  double get totalExpenseDateExpense => _totalExpenseDate;

  void setYear(int year) {
    _selectedYear = year;
    notifyListeners();
  }

  void setMonth(String month) {
    _selectedMonth = month;
    notifyListeners();
  }

  void setTotalExpenses(double expenses) {
    _totalExpenseDate = expenses;
    notifyListeners();
  }

  ValueNotifier<String> changeScreenWidgets = ValueNotifier("");
  void clickAddButton(String page) {
    changeScreenWidgets.value = page;
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  /// ADDED BY NAHEEL ////////////////////////////////////////////////////////////////////
  /// THIS SECTION IS FOR ADDING A NEW COMPANY AND MANAGING COMPANY DATA /////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////

  bool _isLoadingAddCompany = false;
  bool get isLoadingAddCompany => _isLoadingAddCompany;

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController taxIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void setLoadingAddCompany(bool value) {
    _isLoadingAddCompany = value;
    notifyListeners();
  }

  Future<bool> addNewCompany({required BuildContext context, required String userId}) async {
    final String companyName = companyNameController.text.trim();
    final String address = addressController.text.trim();
    final String taxId = taxIdController.text.trim();
    final String contactNumber = contactNumberController.text.trim();
    final String password = passwordController.text.trim();
    final String email = emailController.text.trim();

    setLoadingAddCompany(true);

    try {
      // 🔐 Step 1: Register email in Firebase Authentication
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      final newCompanyId = userCredential.user?.uid;

      if (newCompanyId == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account creation failed. Please try again later.'), backgroundColor: Colors.red, duration: Duration(seconds: 3)));
        throw Exception('FirebaseAuth returned null UID after account creation');
      }

      // ✅ Step 2: Add company data to Firestore
      DocumentReference companyRef = db.collection('COMPANY').doc(newCompanyId);

      await companyRef.set({
        'COMPANY_NAME': companyName,
        'ADDRESS': address,
        'TAX_ID': taxId,
        'EMAIL': email,
        'CONTACT_NUMBER': contactNumber,
        'ADDED_DATE': FieldValue.serverTimestamp(),
        'ADDED_BY': userId,
        'STATUS': 'ACTIVE',
        'ROLE': 'COMPANY',
        'PASSWORD': password,
      }, SetOptions(merge: true));

      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Auth Error: ${e.message}'), backgroundColor: Colors.red));
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding company: $e. Please try again'), backgroundColor: Colors.red));
      return false;
    } finally {
      setLoadingAddCompany(false);
    }
  }

  StreamSubscription? _companySubscription;

  List<CompanyModel> _companies = [];
  List<CompanyModel> get companies => _companies;

  Future<void> fetchInitialCompaniesAndListen() async {
    try {

      // Step 1: Immediate fetch
      final querySnapshot = await db.collection('COMPANY').get();
      _companies = querySnapshot.docs.map((doc) {
            return CompanyModel.fromMap(doc.data());
      }).toList();

      debugPrint('✅ First fetch: ${_companies.length} companies');

      // Step 2: Realtime updates
      _companySubscription = db.collection('COMPANY').snapshots().listen((querySnapshot) {
        _companies = querySnapshot.docs.map((doc) {
              return CompanyModel.fromMap(doc.data());
      }).toList();

        debugPrint('🔄 Realtime update: ${_companies.length} companies');
        notifyListeners();
      }, onError: (e) => debugPrint('❌ Realtime error: $e'));
    } catch (e) {
      debugPrint('❌ Initial fetch error: $e');
      notifyListeners();
    }
  }

  // Future<void> startListeningToCompanies() async {
  //   _companySubscription = db
  //       .collection('COMPANY')
  //       .snapshots()
  //       .listen(
  //         (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
  //           _companies =
  //               querySnapshot.docs.map((doc) {
  //                 final data = doc.data();
  //                 return CompanyModel.fromMap(data);
  //               }).toList();

  //           print('🔥 Companies updated: ${_companies.length} companies found');

  //           notifyListeners();
  //         },
  //         onError: (error) {
  //           debugPrint('🔥 Error listening to companies: $error');
  //         },
  //         cancelOnError: false, // Optional: decide whether to stop listening on error
  //       );
  // }

  void disposeListener() {
    _companySubscription?.cancel();
  }

  bool validateCompanyInputs(BuildContext context) {
    if (companyNameController.text.trim().isEmpty) {
      _showError(context, 'Please enter the company name');
      return false;
    }
    if (addressController.text.trim().isEmpty) {
      _showError(context, 'Please enter the company address');
      return false;
    }
    if (taxIdController.text.trim().isEmpty) {
      _showError(context, 'Please enter the tax ID');
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      _showError(context, 'Please enter the email');
      return false;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text.trim())) {
      _showError(context, 'Please enter a valid email address');
      return false;
    }
    if (contactNumberController.text.trim().isEmpty) {
      _showError(context, 'Please enter the contact number');
      return false;
    }
    if (!RegExp(r'^[0-9]{10,}$').hasMatch(contactNumberController.text.trim())) {
      _showError(context, 'Please enter a valid contact number');
      return false;
    }
    if (passwordController.text.trim().isEmpty) {
      _showError(context, 'Please enter a password');
      return false;
    }
    if (passwordController.text.trim().length < 6) {
      _showError(context, 'Password should be at least 6 characters');
      return false;
    }

    return true;
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  /// THE SECTION ENDED BY NAHEEL CREATIONS //////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
}

class Expense {
  final String category;
  final double amount;

  Expense({required this.category, required this.amount});
}
