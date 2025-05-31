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
import 'package:ledgifi/constants/functions.dart';
import 'package:ledgifi/main.dart';
import 'package:ledgifi/model/company_model.dart';
import 'package:ledgifi/model/ledger_model.dart';
import 'package:ledgifi/model/user_model.dart';
import 'package:ledgifi/model/vendor_model.dart';

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

  void showError(BuildContext context, String message, {Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: backgroundColor));
  }

  bool _isLoadingAddCompany = false;
  bool get isLoadingAddCompany => _isLoadingAddCompany;

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyAddressController = TextEditingController();
  final TextEditingController companyTaxIdController = TextEditingController();
  final TextEditingController companyEmailController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  String companyNameError = '';
  String companyAddressError = '';
  String companyTaxIdError = '';
  String companyEmailError = '';
  String companyContactNumberError = '';

  void setLoadingAddCompany(bool value) {
    _isLoadingAddCompany = value;
    notifyListeners();
  }

  bool isCompanyEditing = false;
  String companyId = '';

  void setCompanyIsEditing(bool value, String newCompanyId) {
    isCompanyEditing = value;
    companyId = newCompanyId;
    notifyListeners();
  }

  Future<bool> addNewCompany({required BuildContext context, required String userId, required String userName}) async {
    final String companyName = companyNameController.text.trim();
    final String address = companyAddressController.text.trim();
    final String taxId = companyTaxIdController.text.trim();
    final String contactNumber = contactNumberController.text.trim();
    final String email = companyEmailController.text.trim();

    setLoadingAddCompany(true);

    try {
      final DateTime now = DateTime.now();

      // Set metadata
      final Map<String, dynamic> metaData =
          isCompanyEditing
              ? {'EDITED_BY_ID': userId, 'EDITED_BY_NAME': userName, 'EDITED_ON': FieldValue.serverTimestamp()}
              : {'ADDED_BY_ID': userId, 'ADDED_BY_NAME': userName, 'ADDED_ON': FieldValue.serverTimestamp()};

      final Map<String, dynamic> data = {
        'COMPANY_ID': companyId,
        'COMPANY_NAME': companyName,
        'EMAIL': email,
        'ADDRESS': address,
        'PHONE': contactNumber,
        'TAX_ID': taxId,
        'STATUS': 'ACTIVE',
        ...metaData,
      };

      final DocumentReference companyRef = db.collection('COMPANIES').doc(companyId);

      await companyRef.set(data, SetOptions(merge: true));

      // Add local timestamp for UI usage
      if (isCompanyEditing) {
        data['EDITED_ON'] = Timestamp.fromDate(now);
      } else {
        data['ADDED_ON'] = Timestamp.fromDate(now);
      }

      // Update local model list
      final int existingIndex = _companiesList.indexWhere((c) => c.companyId == companyId);

      if (existingIndex >= 0) {
        _companiesList[existingIndex] = CompanyModel.fromJson(data);
      } else {
        _companiesList.add(CompanyModel.fromJson(data));
      }

      if (isCompanyEditing) {
        showError(context, 'Company edited successfully', backgroundColor: Colors.green);
      }

      clearCompanyControllers();
      return true;
    } catch (e) {
      showError(context, 'Failed to save company: $e');
      print('Failed to save company: $e');
      return false;
    } finally {
      setLoadingAddCompany(false);
    }
  }

  List<CompanyModel> _companiesList = [];
  List<CompanyModel> get companies => _companiesList;

  Future<void> fetchCompanies() async {
    try {
      final querySnapshot = await db.collection('COMPANIES').get();

      _companiesList = querySnapshot.docs.map((doc) => CompanyModel.fromJson(doc.data())).where((company) => company.status == 'ACTIVE').toList();

      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error fetching companies: $e');
    }
  }

  bool isLoadingCompanyDelete = false;

  void setCompanyDeleteLoading(value) {
    isLoadingCompanyDelete = value;
    notifyListeners();
  }

  Future<void> deleteCompany(BuildContext context, String companyId) async {
    setCompanyDeleteLoading(true);

    try {
      // Mark company as deleted in Firestore
      await db.collection('COMPANIES').doc(companyId).set({'STATUS': 'DELETE'}, SetOptions(merge: true));

      // Remove from local model lists
      _companiesList.removeWhere((company) => company.companyId == companyId);

      back(context);
      setCompanyDeleteLoading(false);

      showError(context, 'Company deleted successfully', backgroundColor: Colors.green);
    } catch (e) {
      back(context);
      setCompanyDeleteLoading(false);

      debugPrint('Error deleting company: $e');
      showError(context, 'Error deleting company', backgroundColor: Colors.red);
    }
  }

  bool validateCompanyForm() {
    bool isValid = true;

    // Validate Company Name
    if (companyNameController.text.trim().isEmpty) {
      companyNameError = 'Company name is required';
      isValid = false;
    } else {
      companyNameError = '';
    }

    // Validate Address
    if (companyAddressController.text.trim().isEmpty) {
      companyAddressError = 'Address is required';
      isValid = false;
    } else {
      companyAddressError = '';
    }

    // Validate Tax ID
    if (companyTaxIdController.text.trim().isEmpty) {
      companyTaxIdError = 'Tax ID is required';
      isValid = false;
    } else {
      companyTaxIdError = '';
    }

    // Validate Email
    String email = companyEmailController.text.trim();
    if (email.isEmpty) {
      companyEmailError = 'Email is required';
      isValid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
      companyEmailError = 'Enter a valid email';
      isValid = false;
    } else {
      companyEmailError = '';
    }

    // Validate Contact Number
    String phone = contactNumberController.text.trim();
    if (phone.isEmpty) {
      companyContactNumberError = 'Contact number is required';
      isValid = false;
    } else {
      companyContactNumberError = '';
    }

    notifyListeners();
    return isValid;
  }

  void setCompanyFormFields({required String companyName, required String address, required String taxId, required String email, required String contactNumber}) {
    companyNameController.text = companyName;
    companyAddressController.text = address;
    companyTaxIdController.text = taxId;
    companyEmailController.text = email;
    contactNumberController.text = contactNumber;
  }

  void clearCompanyControllers() {
    companyNameController.clear();
    companyAddressController.clear();
    companyTaxIdController.clear();
    companyEmailController.clear();
    contactNumberController.clear();
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //// USER ADDING PROCCESS /////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userSurnameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();
  final TextEditingController userContactNumberController = TextEditingController();

  String userSelectedRole = 'Accounts';

  String? userNameError = '';
  String? userSurnameError = '';
  String? userEmailError = '';
  String? userPasswordError = '';
  String? userContactNumberError = '';

  bool isLoadingUserAdding = false;

  void setUserSelectedAccess(value) {
    userSelectedRole = value;
    notifyListeners();
  }

  void setLoadingUser(bool value) {
    isLoadingUserAdding = value;
    notifyListeners();
  }

  bool isUserEditing = false;

  void setIsUserEditing(bool value) {
    isUserEditing = value;
    notifyListeners();
  }

  Future<bool> addUser({required BuildContext context, required String addedById, required String addedByName}) async {
    try {
      setLoadingUser(true);
      final FirebaseAuth auth = FirebaseAuth.instance;

      // Trim input
      final String name = userNameController.text.trim();
      final String surName = userSurnameController.text.trim();
      final String phone = userContactNumberController.text.trim();
      final String email = userEmailController.text.trim();
      final String password = userPasswordController.text.trim();
      final DateTime now = DateTime.now();
      final Map<String, dynamic> metaData = {};
      String userId;

      List<String> keywords = generateSearchKeywords(name, phone, userSelectedRole);

      if (isUserEditing && selectedUserId.isNotEmpty) {
        /// EDIT MODE

        final existingUserData = selectedUser;
        final String existingEmail = existingUserData!.email;
        final String existingPassword = existingUserData.password;

        // Check if email or password changed
        if (existingEmail != email || existingPassword != password) {
          showError(context, "You can't change the email and password. Only after deleting the user and recreating the user.");
          return false;
        }

        userId = selectedUserId;
        metaData['EDITED_BY_ID'] = addedById;
        metaData['EDITED_BY_NAME'] = addedByName;
        metaData['EDITED_ON'] = FieldValue.serverTimestamp();
      } else {
        /// ADD MODE

        UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

        userId = userCredential.user!.uid;
        metaData['ADDED_BY_ID'] = addedById;
        metaData['ADDED_BY_NAME'] = addedByName;
        metaData['ADDED_ON'] = FieldValue.serverTimestamp();
      }

      final userData = {
        'USER_ID': userId,
        'NAME': name,
        'SUR_NAME': surName,
        'PHONE': phone,
        'EMAIL': email,
        'PASSWORD': password,
        'ROLE': userSelectedRole,
        'STATUS': 'ACTIVE',
        'KEY_WORDS': keywords,
        ...metaData,
      };

      // Upload to Firestore
      await db.collection('USERS').doc(userId).set(userData, SetOptions(merge: true));

      // Local timestamp for model/UI
      if (isUserEditing) {
        userData['EDITED_ON'] = Timestamp.fromDate(now);
      } else {
        userData['ADDED_ON'] = Timestamp.fromDate(now);
      }

      // Update local user list
      final int index = userList.indexWhere((u) => u.userId == userId);
      if (index >= 0) {
        userList[index] = UserModel.from(userData);
      } else {
        userList.add(UserModel.from(userData));
      }

      if (isUserEditing) {
        showError(context, 'User edited successfully', backgroundColor: Colors.green);
      }

      clearUserControllers();
      return true;
    } catch (e) {
      showError(context, 'Failed to save user: $e');
      return false;
    } finally {
      setLoadingUser(false);
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  Future<void> deleteUser(BuildContext context, String userId) async {
    setLoadingUser(true);

    try {
      // Update status to 'DELETE' in Firestore
      await db.collection('USERS').doc(userId).set({'STATUS': 'DELETE'}, SetOptions(merge: true));

      // Remove from local lists
      userList.removeWhere((user) => user.userId == userId);

      back(context);
      setLoadingUser(false);

      // Show success message
      showError(context, 'User deleted successfully', backgroundColor: Colors.green);
    } catch (e) {
      back(context);
      setLoadingUser(false);

      debugPrint('Error deleting user: $e');
      showError(context, 'Error deleting user', backgroundColor: Colors.red);
    }
  }

  bool validateUserForm() {
    bool isValid = true;

    // Validate Name
    if (userNameController.text.trim().isEmpty) {
      userNameError = 'Name is required';
    } else {
      userNameError = '';
    }

    // Validate Surname
    if (userSurnameController.text.trim().isEmpty) {
      userSurnameError = 'Surname is Optional';
      isValid = false;
    } else {
      userSurnameError = '';
    }

    // Validate Email
    String email = userEmailController.text.trim();
    if (email.isEmpty) {
      userEmailError = 'Email is required';
      isValid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
      userEmailError = 'Enter a valid email';
      isValid = false;
    } else {
      userEmailError = '';
    }

    // Validate Password
    String password = userPasswordController.text;
    if (password.isEmpty) {
      userPasswordError = 'Password is required';
      isValid = false;
    } else if (password.length < 6) {
      userPasswordError = 'Password must be at least 6 characters';
      isValid = false;
    } else {
      userPasswordError = '';
    }

    // Validate Contact Number
    String contact = userContactNumberController.text.trim();
    if (contact.isEmpty) {
      userContactNumberError = 'Contact number is required';
      isValid = false;
    } else {
      userContactNumberError = '';
    }

    notifyListeners();

    return isValid;
  }

  String selectedUserId = '';
  UserModel? selectedUser;

  void setUserControllers({required UserModel user, required String userId, required String name, required String surName, required String email, required String password, required String phone}) {
    selectedUser = user;
    selectedUserId = user.userId;
    userNameController.text = name;
    userSurnameController.text = surName;
    userEmailController.text = email;
    userPasswordController.text = password;
    userContactNumberController.text = phone;
  }

  void clearUserControllers() {
    userNameController.clear();
    userSurnameController.clear();
    userEmailController.clear();
    userPasswordController.clear();
    userContactNumberController.clear();
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //// VENDOR ADDING PROCESS ////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  final TextEditingController vendorNameController = TextEditingController();
  final TextEditingController vendorEmailController = TextEditingController();
  final TextEditingController vendorAddressController = TextEditingController();
  final TextEditingController vendorPhoneController = TextEditingController();
  final TextEditingController vendorContactPersonController = TextEditingController();
  final TextEditingController vendorOpeningBalanceController = TextEditingController();
  final TextEditingController vendorBalanceAmountController = TextEditingController();

  // Matching FocusNodes
  final FocusNode vendorNameFocus = FocusNode();
  final FocusNode vendorEmailFocus = FocusNode();
  final FocusNode vendorAddressFocus = FocusNode();
  final FocusNode vendorPhoneFocus = FocusNode();
  final FocusNode vendorContactPersonFocus = FocusNode();
  final FocusNode vendorOpeningBalanceFocus = FocusNode();

  String? vendorNameError = '';
  String? vendorEmailError = '';
  String? vendorAddressError = '';
  String? vendorPhoneError = '';
  String? vendorContactPersonError = '';
  String? vendorOpeningBalanceError = '';
  String? vendorBalanceAmountError = '';

  bool isLoadingVendorAdding = false;

  bool isVendorEditing = false;
  String vendorId = '';

  void setLoadingVendor(bool value) {
    isLoadingVendorAdding = value;
    notifyListeners();
  }

  void setVendorIsEditing(bool value, String newVendorId) {
    isVendorEditing = value;
    vendorId = newVendorId;
    notifyListeners();
  }

  Future<bool> addVendor({required BuildContext context, required String addedById, required String addedByName, required String companyId, required String companyName}) async {
    try {
      setLoadingVendor(true);

      // Trim and extract input
      final String name = vendorNameController.text.trim();
      final String email = vendorEmailController.text.trim();
      final String address = vendorAddressController.text.trim();
      final String phone = vendorPhoneController.text.trim();
      final String contactPerson = vendorContactPersonController.text.trim();
      final double openingBalance = double.tryParse(vendorOpeningBalanceController.text.trim()) ?? 0.0;
      final double balanceAmount = double.tryParse(vendorBalanceAmountController.text.trim()) ?? 0.0;

      List<String> keywords = generateSearchKeywords(name, phone);

      // Determine metadata based on edit state
      final Map<String, dynamic> metaData =
          isVendorEditing
              ? {'EDITED_BY_ID': addedById, 'EDITED_BY_NAME': addedByName, 'EDITED_ON': FieldValue.serverTimestamp()}
              : {'ADDED_BY_ID': addedById, 'ADDED_BY_NAME': addedByName, 'ADDED_ON': FieldValue.serverTimestamp()};

      // Vendor map to be stored
      final Map<String, dynamic> vendor = {
        'VENDOR_ID': vendorId,
        'NAME': name,
        'EMAIL': email,
        'ADDRESS': address,
        'PHONE': phone,
        'CONTACT_PERSON': contactPerson,
        'OPENING_BALANCE': openingBalance,
        'BALANCE_AMOUNT': balanceAmount,
        'STATUS': "ACTIVE",
        'COMPANY_NAME': companyName,
        'COMPANY_ID': companyId,
        'KEY_WORDS': keywords,
        ...metaData,
      };

      // Save vendor to Firestore
      await db.collection('VENDORS').doc(vendorId).set(vendor, SetOptions(merge: true));

      if (isVendorEditing && vendorCurrentPageIndex > 0) {
        showError(context, 'Vendor edited successfully', backgroundColor: Colors.green);
        refreshCurrentVendorPage();
      } else {
        showError(context, 'Vendor added successfully', backgroundColor: Colors.green);
        fetchInitialVendors();
      }

      // showError(context, isVendorEditing ? 'Vendor edited successfully' : 'Vendor added successfully', backgroundColor: Colors.green);

      clearVendorControllers();
      return true;
    } catch (e) {
      showError(context, 'Failed to add vendor: $e');
      return false;
    } finally {
      setLoadingVendor(false);
    }
  }

  Future<void> deleteVendor(BuildContext context, String vendorId) async {
    setLoadingVendor(true);

    try {
      // Update status to 'DELETE' in Firestore
      await db.collection('VENDORS').doc(vendorId).set({'STATUS': 'DELETE'}, SetOptions(merge: true));

      // Remove from local lists
      // _vendorsList.removeWhere((vendor) => vendor.vendorId == vendorId);
      // _filteredVendors.removeWhere((vendor) => vendor.vendorId == vendorId);

      back(context);
      setLoadingVendor(false);

      // Show success message
      showError(context, 'Vendor deleted successfully', backgroundColor: Colors.green);
    } catch (e) {
      back(context);
      setLoadingVendor(false);

      debugPrint('Error deleting vendor: $e');
      showError(context, 'Error deleting vendor', backgroundColor: Colors.red);
    }
  }

  bool validateVendorForm() {
    bool isValid = true;

    // Validate Name
    if (vendorNameController.text.trim().isEmpty) {
      vendorNameError = 'Vendor name is required';
      isValid = false;
    } else {
      vendorNameError = '';
    }

    // Validate Email
    String email = vendorEmailController.text.trim();
    if (email.isEmpty) {
      vendorEmailError = 'Email is required';
      isValid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
      vendorEmailError = 'Enter a valid email';
      isValid = false;
    } else {
      vendorEmailError = '';
    }

    // Validate Address
    if (vendorAddressController.text.trim().isEmpty) {
      vendorAddressError = 'Address is required';
      isValid = false;
    } else {
      vendorAddressError = '';
    }

    // Validate Phone
    String phone = vendorPhoneController.text.trim();
    if (phone.isEmpty) {
      vendorPhoneError = 'Phone number is required';
      isValid = false;
    } else {
      vendorPhoneError = '';
    }

    // Validate Contact Person
    if (vendorContactPersonController.text.trim().isEmpty) {
      vendorContactPersonError = 'Contact person is required';
      isValid = false;
    } else {
      vendorContactPersonError = '';
    }

    // Validate Opening Balance
    String openingBalance = vendorOpeningBalanceController.text.trim();
    if (openingBalance.isEmpty) {
      vendorOpeningBalanceError = 'Opening balance is required';
      isValid = false;
    } else if (double.tryParse(openingBalance) == null) {
      vendorOpeningBalanceError = 'Enter a valid number';
      isValid = false;
    } else {
      vendorOpeningBalanceError = '';
    }

    notifyListeners();

    return isValid;
  }

  void setVendorControllers({
    required String name,
    required String email,
    required String address,
    required String phone,
    required String contactPerson,
    required double openingBalance,
    required double balanceAmount,
  }) {
    vendorNameController.text = name;
    vendorEmailController.text = email;
    vendorAddressController.text = address;
    vendorPhoneController.text = phone;
    vendorContactPersonController.text = contactPerson;
    vendorOpeningBalanceController.text = openingBalance.toString();
    vendorBalanceAmountController.text = balanceAmount.toString();
  }

  void clearVendorControllers() {
    vendorNameController.clear();
    vendorEmailController.clear();
    vendorAddressController.clear();
    vendorPhoneController.clear();
    vendorContactPersonController.clear();
    vendorOpeningBalanceController.clear();
    vendorBalanceAmountController.clear();
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //// LEDGER ADDING PROCESS ////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  final TextEditingController ledgerNameController = TextEditingController();
  final TextEditingController ledgerOpeningBalanceController = TextEditingController();

  // FocusNodes
  final FocusNode ledgerNameFocus = FocusNode();
  final FocusNode ledgerOpeningBalanceFocus = FocusNode();

  // Error Strings
  String? ledgerNameError = '';
  String? ledgerOpeningBalanceError = '';
  String? selectedGroupError = '';

  // Selected group name and group id
  String selectedGroupName = '';
  String selectedGroupId = '';

  // State flags
  bool isLedgerEditing = false;
  String ledgerId = '';
  bool isLoadingLedgerAdding = false;

  void setLoadingLedger(bool value) {
    isLoadingLedgerAdding = value;
    notifyListeners();
  }

  void setLedgerIsEditing(bool value, String newLedgerId) {
    isLedgerEditing = value;
    ledgerId = newLedgerId;
    notifyListeners();
  }

  void setSelectedGroup(String newGroupName, String newGroupId) {
    selectedGroupName = newGroupName;
    selectedGroupId = newGroupId;
    notifyListeners();
  }

  bool validateLedgerForm() {
    bool isValid = true;

    if (ledgerNameController.text.trim().isEmpty) {
      ledgerNameError = 'Ledger name is required';
      isValid = false;
    } else {
      ledgerNameError = '';
    }

    String openingBalance = ledgerOpeningBalanceController.text.trim();
    if (openingBalance.isEmpty) {
      ledgerOpeningBalanceError = 'Opening balance is required';
      isValid = false;
    } else if (double.tryParse(openingBalance) == null) {
      ledgerOpeningBalanceError = 'Enter a valid number';
      isValid = false;
    } else {
      ledgerOpeningBalanceError = '';
    }

    if (selectedGroupName.isEmpty) {
      selectedGroupError = 'Please select a group';
      isValid = false;
    } else {
      selectedGroupError = '';
    }

    notifyListeners();
    return isValid;
  }

  void setLedgerControllers({required String name, required double openingBalance, required String groupName, required String groupId}) {
    ledgerNameController.text = name;
    ledgerOpeningBalanceController.text = openingBalance.toString();
    selectedGroupName = groupName;
    selectedGroupId = groupId;
  }

  void clearLedgerControllers() {
    ledgerNameController.clear();
    ledgerOpeningBalanceController.clear();
    selectedGroupName = '';
    selectedGroupId = '';
  }

  Future<bool> addLedger({required BuildContext context, required String addedById, required String addedByName, required String companyId, required String companyName}) async {
    try {
      setLoadingLedger(true);

      final String name = ledgerNameController.text.trim();
      final double openingBalance = double.tryParse(ledgerOpeningBalanceController.text.trim()) ?? 0.0;
      final List<String> keywords = generateSearchKeywords(name, selectedGroupName);

      final Map<String, dynamic> metaData =
          isLedgerEditing
              ? {'EDITED_BY_ID': addedById, 'EDITED_BY_NAME': addedByName, 'EDITED_ON': FieldValue.serverTimestamp()}
              : {'ADDED_BY_ID': addedById, 'ADDED_BY_NAME': addedByName, 'ADDED_ON': FieldValue.serverTimestamp()};

      final Map<String, dynamic> ledger = {
        'LEDGER_ID': ledgerId,
        'NAME': name,
        'OPENING_BALANCE': openingBalance,
        'GROUP_NAME': selectedGroupName,
        'GROUP_ID': selectedGroupId,
        'COMPANY_ID': companyId,
        'COMPANY_NAME': companyName,
        'KEY_WORDS': keywords,
        'STATUS': 'ACTIVE',
        ...metaData,
      };

      await db.collection('LEDGERS').doc(ledgerId).set(ledger, SetOptions(merge: true));

      if (isLedgerEditing) {
        print('sdfghjkl');
        showError(navigatorKey.currentContext!, 'Ledger edited successfully', backgroundColor: Colors.green);
        refreshCurrentLedgerPage();
      } else {
        print('nnnnnnnnnnnnnn');
        showError(navigatorKey.currentContext!, 'Ledger added successfully', backgroundColor: Colors.green);
        fetchInitialLedgers();
      }

      return true;
    } catch (e) {
      showError(navigatorKey.currentContext!, 'Failed to add ledger: $e', backgroundColor: Colors.red);
      return false;
    } finally {
      back(navigatorKey.currentContext!);
      setLoadingLedger(false);
      clearLedgerControllers();
    }
  }

  Future<void> deleteLedger(BuildContext context, String ledgerId) async {
    setLoadingLedger(true);

    try {
      await db.collection('LEDGERS').doc(ledgerId).set({'STATUS': 'DELETE'}, SetOptions(merge: true));

      back(context);
      showError(context, 'Ledger deleted successfully', backgroundColor: Colors.green);
    } catch (e) {
      back(context);
      debugPrint('Error deleting ledger: $e');
      showError(context, 'Error deleting ledger', backgroundColor: Colors.red);
    } finally {
      setLoadingLedger(false);
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  /// USERS PAGINATION FUNCTIONS /////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////

  List<List<DocumentSnapshot>> userPages = [];
  int userCurrentPageIndex = 0;
  DocumentSnapshot? userLastDocument;
  bool isLoadingUsersPagination = false;
  int userDocCount = 0;
  final int userPageSize = 10;
  List<UserModel> userList = [];

  TextEditingController usersSearchController = TextEditingController();

  Future<void> fetchInitialUsers() async {
    isLoadingUsersPagination = true;
    notifyListeners();

    try {
      Query query = db.collection("USERS").where('STATUS', isEqualTo: 'ACTIVE').orderBy("ADDED_ON", descending: true).limit(userPageSize);

      if (usersSearchController.text.isNotEmpty) {
        query = query.where('KEY_WORDS', arrayContains: usersSearchController.text);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        userPages = [snapshot.docs];
        userCurrentPageIndex = 0;
        userLastDocument = snapshot.docs.last;
        _processUsers(snapshot.docs);
      } else {
        userList.clear();
      }

      final countSnap = await db.collection("USERS").where('STATUS', isEqualTo: 'ACTIVE').count().get();
      userDocCount = countSnap.count ?? 0;
    } catch (e) {
      print("Error fetching initial users: $e");
    } finally {
      isLoadingUsersPagination = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextUsers() async {
    if (userLastDocument == null && userPages.isNotEmpty) return;

    isLoadingUsersPagination = true;
    notifyListeners();

    try {
      Query query = db.collection("USERS").where('STATUS', isEqualTo: 'ACTIVE').orderBy("ADDED_ON", descending: true).startAfterDocument(userLastDocument!).limit(userPageSize);

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        userPages.add(snapshot.docs);
        userLastDocument = snapshot.docs.last;
      }
    } catch (e) {
      print("Error fetching next page: $e");
    } finally {
      isLoadingUsersPagination = false;
      notifyListeners();
    }
  }

  Future<void> fetchUsersAtPage(int pageIndex) async {
    if (pageIndex < 0 || pageIndex >= (userDocCount / userPageSize).ceil()) return;

    isLoadingUsersPagination = true;
    notifyListeners();

    if (pageIndex < userPages.length) {
      userCurrentPageIndex = pageIndex;
      _processUsers(userPages[pageIndex]);
      isLoadingUsersPagination = false;
      notifyListeners();
      return;
    }

    try {
      for (int i = userPages.length; i <= pageIndex; i++) {
        await fetchNextUsers();
      }

      if (pageIndex < userPages.length) {
        userCurrentPageIndex = pageIndex;
        _processUsers(userPages[pageIndex]);
      }
    } catch (e) {
      print("Pagination error: $e");
    } finally {
      isLoadingUsersPagination = false;
      notifyListeners();
    }
  }

  void _processUsers(List<DocumentSnapshot> docs) {
    userList = docs.map((doc) => UserModel.from(doc.data() as Map<String, dynamic>)).toList();
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  /// VENDOR PAGINATION FUNCTIONS ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////

  List<List<DocumentSnapshot>> vendorPages = [];
  int vendorCurrentPageIndex = 0;
  DocumentSnapshot? vendorLastDocument;
  DocumentSnapshot? vendorStartDocument;
  bool isLoadingVendorsPagination = false;
  int vendorDocCount = 0;
  final int vendorPageSize = 10;
  List<VendorModel> vendorList = [];

  TextEditingController vendorsSearchController = TextEditingController();

  Future<void> fetchInitialVendors() async {
    isLoadingVendorsPagination = true;
    notifyListeners();

    try {
      Query query = db.collection("VENDORS").where('STATUS', isEqualTo: 'ACTIVE').orderBy("ADDED_ON", descending: true).limit(vendorPageSize);

      if (vendorsSearchController.text.isNotEmpty) {
        query = query.where('KEY_WORDS', arrayContains: vendorsSearchController.text);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        vendorPages = [snapshot.docs];
        vendorCurrentPageIndex = 0;
        vendorLastDocument = snapshot.docs.last;
        vendorStartDocument = snapshot.docs.first;
        _processVendors(snapshot.docs);
      } else {
        vendorList.clear();
      }

      final countSnap = await db.collection("VENDORS").where('STATUS', isEqualTo: 'ACTIVE').count().get();
      vendorDocCount = countSnap.count ?? 0;
    } catch (e) {
      print("Error fetching initial vendors: $e");
    } finally {
      isLoadingVendorsPagination = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextVendors() async {
    if (vendorLastDocument == null && vendorPages.isNotEmpty) return;

    isLoadingVendorsPagination = true;
    notifyListeners();

    try {
      Query query = db.collection("VENDORS").where('STATUS', isEqualTo: 'ACTIVE').orderBy("ADDED_ON", descending: true).startAfterDocument(vendorLastDocument!).limit(vendorPageSize);

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        vendorPages.add(snapshot.docs);
        vendorLastDocument = snapshot.docs.last;
        vendorStartDocument = snapshot.docs.first;
      }
    } catch (e) {
      print("Error fetching next vendor page: $e");
    } finally {
      isLoadingVendorsPagination = false;
      notifyListeners();
    }
  }

  Future<void> fetchVendorsAtPage(int pageIndex) async {
    if (pageIndex < 0 || pageIndex >= (vendorDocCount / vendorPageSize).ceil()) return;

    isLoadingVendorsPagination = true;
    notifyListeners();

    if (pageIndex < vendorPages.length) {
      vendorCurrentPageIndex = pageIndex;
      _processVendors(vendorPages[pageIndex]);
      isLoadingVendorsPagination = false;
      notifyListeners();
      return;
    }

    try {
      for (int i = vendorPages.length; i <= pageIndex; i++) {
        await fetchNextVendors();
      }

      if (pageIndex < vendorPages.length) {
        vendorCurrentPageIndex = pageIndex;
        _processVendors(vendorPages[pageIndex]);
      }
    } catch (e) {
      print("Pagination error: $e");
    } finally {
      isLoadingVendorsPagination = false;
      notifyListeners();
    }
  }

  Future<void> refreshCurrentVendorPage() async {
    isLoadingVendorsPagination = true;
    notifyListeners();

    print("🔄 Refreshing current vendor page... ${vendorLastDocument!.id}");

    try {
      // Build the Firestore query
      Query query = db.collection("VENDORS").where('STATUS', isEqualTo: 'ACTIVE').orderBy("ADDED_ON", descending: true).startAtDocument(vendorStartDocument!).limit(vendorPageSize);

      print("📤 Sending query to Firestore...");

      // Fetch data
      final snapshot = await query.get();

      print("📥 Data fetched. Number of documents: ${snapshot.docs.length}");

      if (snapshot.docs.isNotEmpty) {
        print("✅ Snapshot is not empty. Updating page ${vendorCurrentPageIndex}");

        // Replace the current page in vendorPages
        vendorPages[vendorCurrentPageIndex] = snapshot.docs;

        // Update the last document pointer for pagination
        vendorLastDocument = snapshot.docs.last;
        vendorStartDocument = snapshot.docs.first;

        _processVendors(vendorPages[vendorCurrentPageIndex]);

        print("🔁 Vendor list successfully updated and flattened.");
      } else {
        print("⚠️ Snapshot is empty. No vendors found in refresh.");
      }
    } catch (e) {
      print("❌ Error refreshing current vendor page: $e");
    } finally {
      isLoadingVendorsPagination = false;
      notifyListeners();
      print("✅ Finished refreshCurrentVendorPage()");
    }
  }

  void _processVendors(List<DocumentSnapshot> docs) {
    vendorList = docs.map((doc) => VendorModel.from(doc.data() as Map<String, dynamic>)).toList();
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  //// LEDGER PAGINATION FUNCTIONS ///////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////

  List<List<DocumentSnapshot>> ledgerPages = [];
  int ledgerCurrentPageIndex = 0;
  DocumentSnapshot? ledgerLastDocument;
  DocumentSnapshot? ledgerStartDocument;
  bool isLoadingLedgersPagination = false;
  int ledgerDocCount = 0;
  final int ledgerPageSize = 10;
  List<LedgerModel> ledgerList = [];

  TextEditingController ledgersSearchController = TextEditingController();

  Future<void> fetchInitialLedgers() async {
    isLoadingLedgersPagination = true;
    notifyListeners();

    try {
      Query query = db.collection("LEDGERS").where('STATUS', isEqualTo: 'ACTIVE').orderBy("ADDED_ON", descending: true).limit(ledgerPageSize);

      if (ledgersSearchController.text.isNotEmpty) {
        query = query.where('KEY_WORDS', arrayContains: ledgersSearchController.text.toLowerCase());
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        ledgerPages = [snapshot.docs];
        ledgerCurrentPageIndex = 0;
        ledgerLastDocument = snapshot.docs.last;
        ledgerStartDocument = snapshot.docs.first;
        _processLedgers(snapshot.docs);
      } else {
        ledgerList.clear();
      }

      final countSnap = await db.collection("LEDGERS").where('STATUS', isEqualTo: 'ACTIVE').count().get();
      ledgerDocCount = countSnap.count ?? 0;
    } catch (e) {
      print("Error fetching initial ledgers: $e");
      isLoadingLedgersPagination = false;
      notifyListeners();
    } finally {
      isLoadingLedgersPagination = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextLedgers() async {
    if (ledgerLastDocument == null && ledgerPages.isNotEmpty) return;

    isLoadingLedgersPagination = true;
    notifyListeners();

    try {
      Query query = db.collection("LEDGERS").where('STATUS', isEqualTo: 'ACTIVE').orderBy("ADDED_ON", descending: true).startAfterDocument(ledgerLastDocument!).limit(ledgerPageSize);

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        ledgerPages.add(snapshot.docs);
        ledgerLastDocument = snapshot.docs.last;
        ledgerStartDocument = snapshot.docs.first;
      }
    } catch (e) {
      print("Error fetching next ledger page: $e");
    } finally {
      isLoadingLedgersPagination = false;
      notifyListeners();
    }
  }

  Future<void> fetchLedgersAtPage(int pageIndex) async {
    if (pageIndex < 0 || pageIndex >= (ledgerDocCount / ledgerPageSize).ceil()) return;

    isLoadingLedgersPagination = true;
    notifyListeners();

    if (pageIndex < ledgerPages.length) {
      ledgerCurrentPageIndex = pageIndex;
      _processLedgers(ledgerPages[pageIndex]);
      isLoadingLedgersPagination = false;
      notifyListeners();
      return;
    }

    try {
      for (int i = ledgerPages.length; i <= pageIndex; i++) {
        await fetchNextLedgers();
      }

      if (pageIndex < ledgerPages.length) {
        ledgerCurrentPageIndex = pageIndex;
        _processLedgers(ledgerPages[pageIndex]);
      }
    } catch (e) {
      print("Pagination error: $e");
    } finally {
      isLoadingLedgersPagination = false;
      notifyListeners();
    }
  }

  Future<void> refreshCurrentLedgerPage() async {
    isLoadingLedgersPagination = true;
    notifyListeners();

    print("🔄 Refreshing current ledger page...");

    try {
      Query query = db.collection("LEDGERS").where('STATUS', isEqualTo: 'ACTIVE').orderBy("ADDED_ON", descending: true).startAtDocument(ledgerStartDocument!).limit(ledgerPageSize);

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        print("✅ Refreshing with ${snapshot.docs.length} documents");

        ledgerPages[ledgerCurrentPageIndex] = snapshot.docs;
        ledgerLastDocument = snapshot.docs.last;
        ledgerStartDocument = snapshot.docs.first;

        _processLedgers(ledgerPages[ledgerCurrentPageIndex]);
      } else {
        print("⚠️ No ledgers found in current page refresh.");
      }
    } catch (e) {
      print("❌ Error refreshing ledger page: $e");
    } finally {
      isLoadingLedgersPagination = false;
      notifyListeners();
    }
  }

  void _processLedgers(List<DocumentSnapshot> docs) {
    ledgerList = docs.map((doc) => LedgerModel.from(doc.data() as Map<String, dynamic>)).toList();
    notifyListeners();
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
