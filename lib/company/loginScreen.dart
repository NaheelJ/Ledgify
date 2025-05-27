import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/company/sideBar.dart';
import 'package:ledgifi/constants/functions.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:ledgifi/providers/loginProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenCompany extends StatelessWidget {
  const LoginScreenCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Left Side - Logo with Gradient
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFD23F6D), // 0%
                    Color(0xFF981D44), // 84.79%
                    Color(0xFF841739), // 100%
                  ],
                  stops: [0.0, 0.8479, 1.0],
                ),
              ),
              child: Center(child: Image.asset('asset/icons/logoLidgifi.png', scale: 6, color: Colors.white)),
            ),
          ),

          // Right Side - Login Form
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(36),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD5D7DA)), // border: #D5D7DA
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D0A0D12), // 0A0D120D with opacity
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Login', style: GoogleFonts.notoSans(fontSize: 36, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text('Welcome back! Please enter your details.', style: GoogleFonts.notoSans(color: cl666666, fontWeight: FontWeight.w400, fontSize: 16)),
                    const SizedBox(height: 25),

                    // Email Field
                    Text('Email', style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                    const SizedBox(height: 6),
                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, child) {
                        return TextFormField(
                          controller: loginProvider.emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            hintStyle: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: cl666666)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: clD5D7DA)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: clD5D7DA)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: clFD23F6D)),

                            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    Text('Password', style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                    const SizedBox(height: 6),
                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, child) {
                        return TextFormField(
                          controller: loginProvider.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            hintStyle: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: cl666666)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: clD5D7DA)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: clD5D7DA)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: clFD23F6D)),
                            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Login Button
                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, child) {
                        return Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x0D0A0D12), // #0A0D120D in Flutter (with 0D = ~5% opacity)
                                offset: Offset(0, 1), // x = 0px, y = 1px
                                blurRadius: 2, // blur = 2px
                              ),
                            ],
                          ),
                          child: SizedBox(
                            height: 44,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: cl8F1A3F,
                                elevation: 0, // Remove default shadow to only use custom shadow
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () async {
                                await loginProvider.login(context);
                              },
                              child: Consumer<LoginProvider>(
                                builder:
                                    (context, person, child) =>
                                        person.isLoading
                                            ? SizedBox(
                                                height: 24,
                                                width: 24,
                                              child: const Center(child: CircularProgressIndicator(color: Colors.white)))
                                            : Text('Login', style: GoogleFonts.notoSans(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
