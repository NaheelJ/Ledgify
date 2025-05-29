import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/providers/loginProvider.dart';
import 'package:provider/provider.dart';

import '../../constants/functions.dart';
import '../../constants/myColors.dart';
import '../../providers/mainProvider.dart';

class AddUsersScreen extends StatelessWidget {
  const AddUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    final LoginProvider loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: clwhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD5D7DA)), borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                     mainProvider.clickAddButton('userScreen');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: clwhite, // or Colors.white
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFEBEBEB), width: 0.8),
                      boxShadow: [BoxShadow(color: const Color(0x14000000), blurRadius: 16, offset: Offset(0, 0))],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      CupertinoIcons.back,
                      size: 24,
                      color: Colors.black, // optional
                    ),
                  ),
                ),
                SizedBox(width: 12),

                Text('Add User', style: GoogleFonts.notoSans(fontWeight: FontWeight.w600, fontSize: 19, color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Consumer<MainProvider>(
            builder: (context, mainProvider, child) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // Optional: reduce outer padding if not needed
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(border: Border.all(color: mainProvider.borderColor), borderRadius: BorderRadius.circular(6)),
                              child: TextField(
                                controller: mainProvider.userNameController,
                                focusNode: mainProvider.focusName1,
                                style: GoogleFonts.notoSans(textStyle: TextStyle(color: clblack)),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Name ',
                                      style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.grey, fontSize: 16)),
                                      children: [TextSpan(text: '*', style: TextStyle(color: Colors.red, fontSize: 16))],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) => Text(value.userNameError.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // Optional: reduce outer padding if not needed
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(border: Border.all(color: mainProvider.borderColor), borderRadius: BorderRadius.circular(6)),
                              child: TextField(
                                controller: mainProvider.userSurnameController,
                                focusNode: mainProvider.focusSurname,
                                style: GoogleFonts.notoSans(textStyle: TextStyle(color: clblack)),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Surname ',
                                      style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.grey, fontSize: 16)),
                                      children: [TextSpan(text: '*', style: TextStyle(color: Colors.red, fontSize: 16))],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) => Text(value.userSurnameError.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.orange)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // Optional: reduce outer padding if not needed
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(border: Border.all(color: mainProvider.borderColor), borderRadius: BorderRadius.circular(6)),
                              child: TextField(
                                controller: mainProvider.userEmailController,
                                focusNode: mainProvider.focusEmployee,
                                style: GoogleFonts.notoSans(textStyle: TextStyle(color: clblack)),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Email',
                                      style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.grey, fontSize: 16)),
                                      children: [TextSpan(text: '*', style: TextStyle(color: Colors.red, fontSize: 16))],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) => Text(value.userEmailError.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // Optional: reduce outer padding if not needed
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(border: Border.all(color: mainProvider.borderColor), borderRadius: BorderRadius.circular(6)),
                              child: TextField(
                                controller: mainProvider.userPasswordController,
                                focusNode: mainProvider.focusRole,
                                style: GoogleFonts.notoSans(textStyle: TextStyle(color: clblack)),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Password',
                                      style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.grey, fontSize: 16)),
                                      children: [TextSpan(text: '*', style: TextStyle(color: Colors.red, fontSize: 16))],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) => Text(value.userPasswordError.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // Optional: reduce outer padding if not needed
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(border: Border.all(color: mainProvider.borderColor), borderRadius: BorderRadius.circular(6)),
                              child: TextField(
                                controller: mainProvider.userContactNumberController,
                                focusNode: mainProvider.focusContact1,
                                style: GoogleFonts.notoSans(textStyle: TextStyle(color: clblack)),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Contact Number ',
                                      style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.grey, fontSize: 16)),
                                      children: [TextSpan(text: '*', style: TextStyle(color: Colors.red, fontSize: 16))],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) => Text(value.userContactNumberError.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: 'Access ',
                        style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.grey, fontSize: 16)),
                        children: [TextSpan(text: '*', style: TextStyle(color: Colors.red, fontSize: 16))],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: Row(children: [Expanded(child: accessOption('Admin', context)), const SizedBox(width: 16), Expanded(child: accessOption('Accounts', context))])),
                      const SizedBox(width: 16),
                      Expanded(child: SizedBox()),
                    ],
                  ),

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            mainProvider.clickAddButton('userScreen');
                            // Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            side: const BorderSide(color: Color(0xFFD5D7DA), width: 1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            elevation: 0,
                          ),
                          child: const Text("Cancel", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 150,
                        height: 40,
                        child: Consumer<MainProvider>(
                          builder:
                              (context, person, child) => ElevatedButton(
                                onPressed: () async {
                                  if (person.isLoadingUserAdding) return;

                                  bool isValid = mainProvider.validateUserForm();

                                  if (!isValid) return;

                                  bool userAddingSuccess = await mainProvider.addUser(context: context, addedById: loginProvider.usermodel!.userId, addedByName: loginProvider.usermodel!.name);

                                  if (userAddingSuccess) {
                                    showSuccessDialog(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: cl8F1A3F,
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Color(0xFFD5D7DA), width: 1),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  elevation: 0,
                                ),
                                child:
                                    person.isLoadingUserAdding
                                        ? SizedBox(height: 24, width: 24, child: const Center(child: CircularProgressIndicator(color: Colors.white)))
                                        : Text("Save", style: TextStyle(color: clwhite, fontSize: 16, fontWeight: FontWeight.w500)),
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 4), () {
          Provider.of<MainProvider>(context, listen: false).clickAddButton('userScreen');
          Navigator.pop(context);
        });
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              color: clwhite, // Light green background
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('asset/gif/success.gif', scale: 1.5),
                const SizedBox(height: 18),
                Flexible(child: Text('Added New Employee', style: GoogleFonts.notoSans(fontSize: 16, fontWeight: FontWeight.w800))),
                const SizedBox(height: 6),
                Flexible(child: Text('The employee has been successfully added.', style: GoogleFonts.notoSans(fontSize: 14, fontWeight: FontWeight.w400, color: cl808080))),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget accessOption(String title, BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final selectedAccess = mainProvider.userSelectedRole;

    final isSelected = selectedAccess == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => mainProvider.setUserSelectedAccess(title),
        child: Container(
          height: 48,
          decoration: BoxDecoration(color: isSelected ? clF4E8EC : clF2F2F2, border: Border.all(color: isSelected ? cl8F1A3F : clD5D7DA), borderRadius: BorderRadius.circular(6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(color: isSelected ? cl8F1A3F : cl666666, fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: isSelected ? cl8F1A3F : cl666666, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
