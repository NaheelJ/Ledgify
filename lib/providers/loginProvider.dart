import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ledgifi/admin/dashBoard/dashBoardAdmin.dart';
import 'package:ledgifi/company/DashBoard/dashBoardScreen.dart';
import 'package:ledgifi/company/loginScreen.dart';
import 'package:ledgifi/constants/functions.dart';
import 'package:ledgifi/model/user_model.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      setLoading(true);

      final userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user?.uid;
      final userDoc = await db.collection('USERS').doc(uid).get();

      if (!userDoc.exists) {
        _showError(context, "User not found. Please check your credentials.");
        return;
      }

      final data = userDoc.data() as Map<String, dynamic>;
      final role = data['ROLE'] ?? ''; // fallback if ROLE is null

      // Store user email in SharedPreferences
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('USER_ID', uid!);
      await pref.setString('ROLE', role);

      if (role == 'admin') {
        callNextReplacement(DashBoardScreenAdmin(), context);
      } else {
        callNextReplacement(DashBoardScreen(), context);
      }
    } on FirebaseAuthException catch (e) {
      _showError(context, e.message ?? "Login failed. Please try again.");
    } finally {
      setLoading(false);
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  bool validateEmailAndPassword(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) {
      _showError(context, 'Please enter your email');
      return false;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _showError(context, 'Please enter a valid email address');
      return false;
    }

    if (password.isEmpty) {
      _showError(context, 'Please enter your password');
      return false;
    }

    if (password.length < 6) {
      _showError(context, 'Password must be at least 6 characters long');
      return false;
    }

    return true;
  }

  Future<void> userAuthorized(String userId, context) async {
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

    await fetchUserData(userId);
    await mainProvider.fetchInitialCompaniesAndListen();

    String role = usermodel!.role.toString();
    print('User role: $role');

    switch (role) {
      case 'admin':
        callNextReplacement(DashBoardScreenAdmin(), context);
        break;
      case 'accounts':
        callNextReplacement(DashBoardScreen(), context);
        break;
      default:
        callNextReplacement(LoginScreenCompany(), context);
    }
    notifyListeners();
  }

  UserModel? usermodel;

  Future<void> fetchUserData(String userId) async {
    try {
      final doc = await db.collection('USERS').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        usermodel = UserModel.from(doc.data()!, doc.id);
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
