import 'package:flutter/material.dart';
import 'package:ledgifi/company/loginScreen.dart';

import 'homeScreen_Company.dart';
import 'package:flutter/material.dart';

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreenCompany()),
      );
    });
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
          child: Image.asset(
            'asset/icons/logoLidgifi.png',
            scale: 4,
          ),
        ),
      ),
    );
  }
}
