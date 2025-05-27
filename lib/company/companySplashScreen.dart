import 'package:flutter/material.dart';
import 'package:ledgifi/company/loginScreen.dart';
import 'package:ledgifi/providers/loginProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/functions.dart';

class SplashScreenCompany extends StatefulWidget {
  const SplashScreenCompany({super.key});

  @override
  State<SplashScreenCompany> createState() => _SplashScreenCompanyState();
}

class _SplashScreenCompanyState extends State<SplashScreenCompany> with SingleTickerProviderStateMixin {
  double _scale = 0.0;

  @override
  void initState() {
    super.initState();

    // Start the scale animation after a small delay (optional)
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0;
      });
    });

    // Navigate after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      _loadUserData();
    });
  }

  Future<void> _loadUserData() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    try {
      final pref = await SharedPreferences.getInstance();
      final userId = pref.getString('USER_ID') ?? '';
      final role = pref.getString('ROLE') ?? '';

      if (userId.isEmpty) {
        callNextReplacement(LoginScreenCompany(), context);
        return;
      }

      await loginProvider.userAuthorized(userId, role, context);
    } catch (e) {
      callNextReplacement(LoginScreenCompany(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 500), // scale animation duration
          curve: Curves.easeOutBack,
          child: Image.asset('asset/icons/logoLidgifi.png', scale: 4),
        ),
      ),
    );
  }
}
