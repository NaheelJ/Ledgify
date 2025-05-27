import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier{
  final FirebaseFirestore db = FirebaseFirestore.instance;
/// login provider manually
  String? _userId;

  String? get userId => _userId;

  // ✅ Step 1: Basic format validation
  bool _isValidEmailFormat(String email) {
    final trimmedEmail = email.trim();
    final regex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return regex.hasMatch(trimmedEmail);
  }
  // ✅ Step 2: Very basic fake domain check
  bool _isValidDomain(String email) {
    final domain = email.split('@').last;
    return domain.contains('.') && domain.length >= 5;
  }

  Future<String> login(String email, String password) async {
    if (!_isValidEmailFormat(email)) {
      return 'Invalid email format';
    }
    if (!_isValidDomain(email)) {
      return 'Invalid email domain';
    }
    try {
      // ✅ Step 3: Check Firestore USERS collection
      final snapshot = await db.collection('USERS')
          .where('EMAIL', isEqualTo: email).get();

      if (snapshot.docs.isEmpty) {
        return 'Email not found';
      }

      final userData = snapshot.docs.first.data() as Map<String, dynamic>;

      // ✅ Step 4: Match password
      if (userData['PASSWORD'] == password) {
        _userId = snapshot.docs.first.id;
        notifyListeners();
        final SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString("EMAIL",emailController.text.trim());
        await pref.setString("PASSWORD",passwordController.text.trim());
        return 'success';
      } else {
        return 'Incorrect password';
      }
    } catch (e) {
      print('Login error: $e');
      return 'Login failed';
    }
  }
  ///
  /*final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    _user = user;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }*/

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();




  Future<void> addUser() async {
    try {
      await FirebaseFirestore.instance.collection('USERS').add({
        'EMAIL': emailController.text,
        'PASSWORD': passwordController.text,
        'created_at': FieldValue.serverTimestamp(), // optional timestamp
      });
      print('✅ User added successfully');
    } catch (e) {
      print('❌ Failed to add user: $e');
    }
  }

}