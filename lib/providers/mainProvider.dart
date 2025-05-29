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
  final TextEditingController addressController = TextEditingController();
  final TextEditingController taxIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  void setLoadingAddCompany(bool value) {
    _isLoadingAddCompany = value;
    notifyListeners();
  }

  Future<bool> addNewCompany({required BuildContext context, required String userId, required String userName, required String companyId}) async {
    final String companyName = companyNameController.text.trim();
    final String address = addressController.text.trim();
    final String taxId = taxIdController.text.trim();
    final String contactNumber = contactNumberController.text.trim();
    final String email = emailController.text.trim();

    setLoadingAddCompany(true);

    try {
      final Map<String, dynamic> data = {
        'COMPANY_ID': companyId,
        'COMPANY_NAME': companyName,
        'EMAIL': email,
        'ADDRESS': address,
        'PHONE': contactNumber,
        'TAX_ID': taxId,
        'ADDED_BY_ID': userId,
        'ADDED_BY_NAME': userName,
        'ADDED_ON': FieldValue.serverTimestamp(),
      };

      final DocumentReference companyRef = FirebaseFirestore.instance.collection('COMPANIES').doc(companyId);

      await companyRef.set(data, SetOptions(merge: true));
      clearCompanyControllers();
      return true;
    } catch (e) {
      showError(context, 'Failed to add company: $e');
      return false;
    } finally {
      setLoadingAddCompany(false);
    }
  }

  StreamSubscription? _companySubscription;

  List<CompanyModel> _companies = [];
  List<CompanyModel> get companies => _companies;

  Future<void> fetchCompanies() async {
    try {
      final querySnapshot = await db.collection('COMPANIES').get();

      _companies = querySnapshot.docs.map((doc) => CompanyModel.fromJson(doc.data())).toList();

      debugPrint('✅ Fetched ${_companies.length} companies');
      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error fetching companies: $e');
    }
  }

  bool validateCompanyInputs(BuildContext context) {
    if (companyNameController.text.trim().isEmpty) {
      showError(context, 'Please enter the company name');
      return false;
    }
    if (addressController.text.trim().isEmpty) {
      showError(context, 'Please enter the company address');
      return false;
    }
    if (taxIdController.text.trim().isEmpty) {
      showError(context, 'Please enter the tax ID');
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      showError(context, 'Please enter the email');
      return false;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text.trim())) {
      showError(context, 'Please enter a valid email address');
      return false;
    }
    if (contactNumberController.text.trim().isEmpty) {
      showError(context, 'Please enter the contact number');
      return false;
    }
    if (contactNumberController.text.isEmpty) {
      showError(context, 'Please enter a Contact number');
      return false;
    }

    return true;
  }

  void clearCompanyControllers() {
    userNameController.clear();
    userSurnameController.clear();
    userEmailController.clear();
    userPasswordController.clear();
    userContactNumberController.clear();
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //// USER ADDING PROCCESS /////////////////////////////////////////////////////////////////////////////////////
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

      // Date Time Now
      final DateTime now = DateTime.now();

      // Meta Data
      final Map<String, dynamic> metaData = {};
      String userId;

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

      final userData = {'USER_ID': userId, 'NAME': name, 'SUR_NAME': surName, 'PHONE': phone, 'EMAIL': email, 'PASSWORD': password, 'ROLE': userSelectedRole, 'STATUS': 'Active', ...metaData};

      // Upload to Firestore
      await db.collection('USERS').doc(userId).set(userData, SetOptions(merge: true));

      // Local timestamp for model/UI
      if (isUserEditing) {
        userData['EDITED_ON'] = Timestamp.fromDate(now);
      } else {
        userData['ADDED_ON'] = Timestamp.fromDate(now);
      }

      // Update local user list
      final int index = _usersList.indexWhere((u) => u.userId == userId);
      if (index >= 0) {
        _usersList[index] = UserModel.from(userData);
      } else {
        _usersList.add(UserModel.from(userData));
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

  List<UserModel> _usersList = [];
  List<UserModel> get usersList => _usersList;

  Future<void> fetchUsersList() async {
    try {
      final snapshot = await db.collection('USERS').orderBy('ADDED_ON', descending: true).get();

      _usersList = snapshot.docs.map((doc) => UserModel.from(doc.data())).toList();

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching users: $e');
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

  void setVendorIsEditing(bool value, String newVendorId) {
    isVendorEditing = value;
    vendorId = newVendorId;
    notifyListeners();
  }

  void setLoadingVendor(bool value) {
    isLoadingVendorAdding = value;
    notifyListeners();
  }

  Future<bool> addVendor({required BuildContext context, required String addedById, required String addedByName}) async {
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

      final DateTime dateTimeNow = DateTime.now();

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
        ...metaData,
      };

      // Save vendor to Firestore
      await db.collection('VENDORS').doc(vendorId).set(vendor, SetOptions(merge: true));

      // Locally add the timestamp for UI or model use
      if (isVendorEditing) {
        vendor['EDITED_ON'] = Timestamp.fromDate(dateTimeNow);
      } else {
        vendor['ADDED_ON'] = Timestamp.fromDate(dateTimeNow);
      }

      // Check if vendor already exists in vendorsList
      final int existingIndex = vendorsList.indexWhere((v) => v.vendorId == vendorId);

      if (existingIndex >= 0) {
        // Update existing vendor
        vendorsList[existingIndex] = VendorModel.from(vendor);
      } else {
        // Add to local model list
        vendorsList.add(VendorModel.from(vendor));
      }

      showError(context, 'Vendor added successfully', backgroundColor: Colors.green);

      clearVendorControllers();
      return true;
    } catch (e) {
      showError(context, 'Failed to add vendor: $e');
      return false;
    } finally {
      setLoadingVendor(false);
    }
  }

  List<VendorModel> _vendorsList = [];
  List<VendorModel> get vendorsList => _vendorsList;

  Future<void> fetchVendorsList() async {
    try {
      final snapshot = await db.collection('VENDORS').orderBy('ADDED_ON', descending: true).get();

      _vendorsList = snapshot.docs.map((doc) => VendorModel.from(doc.data())).toList();

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching vendors: $e');
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
