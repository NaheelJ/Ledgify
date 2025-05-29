import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/providers/loginProvider.dart';
import 'package:provider/provider.dart';

import '../../../constants/myColors.dart';
import '../../../providers/mainProvider.dart';

class AddVentorScreen extends StatelessWidget {
  const AddVentorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = Provider.of<LoginProvider>(context, listen: false);

    var width = MediaQuery.of(context).size.width;
    String selectedAccount = 'Cash in Hand';

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
                Consumer<MainProvider>(
                  builder: (context, mainProvider, child) {
                    return InkWell(
                      onTap: () {
                        mainProvider.clickAddButton('addPurchase');
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
                    );
                  },
                ),
                SizedBox(width: 12),

                Text('Add Vendor', style: GoogleFonts.notoSans(fontWeight: FontWeight.w600, fontSize: 19, color: Colors.black)),
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
                                controller: mainProvider.vendorNameController,
                                focusNode: mainProvider.vendorNameFocus,
                                style: GoogleFonts.notoSans(textStyle: TextStyle(color: clblack)),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Vendor Name ',
                                      style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.grey, fontSize: 16)),
                                      children: [TextSpan(text: '*', style: TextStyle(color: Colors.red, fontSize: 16))],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) => Text(value.vendorNameError.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
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
                                controller: mainProvider.vendorPhoneController,
                                focusNode: mainProvider.vendorPhoneFocus,
                                style: GoogleFonts.notoSans(textStyle: TextStyle(color: clblack)),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Contact Number   ',
                                      style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.grey, fontSize: 16)),
                                      children: [TextSpan(text: '*', style: TextStyle(color: Colors.red, fontSize: 16))],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) => Text(value.vendorPhoneError.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
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
                                controller: mainProvider.vendorEmailController,
                                focusNode: mainProvider.vendorEmailFocus,
                                style: GoogleFonts.notoSans(textStyle: TextStyle(color: clblack)),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Email  ',
                                      style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.grey, fontSize: 16)),
                                      children: [TextSpan(text: '*', style: TextStyle(color: Colors.red, fontSize: 16))],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) => Text(value.vendorEmailError.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
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
                                controller: mainProvider.vendorAddressController,
                                focusNode: mainProvider.vendorAddressFocus,
                                style: GoogleFonts.notoSans(textStyle: TextStyle(color: clblack)),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Address   ',
                                      style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.grey, fontSize: 16)),
                                      children: [TextSpan(text: '*', style: TextStyle(color: Colors.red, fontSize: 16))],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) => Text(value.vendorAddressError.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
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
                                controller: mainProvider.vendorContactPersonController,
                                focusNode: mainProvider.vendorContactPersonFocus,
                                style: GoogleFonts.notoSans(textStyle: TextStyle(color: clblack)),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Contact Person ',
                                      style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.grey, fontSize: 16)),
                                      children: [TextSpan(text: '*', style: TextStyle(color: Colors.red, fontSize: 16))],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) => Text(value.vendorContactPersonError.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
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
                                controller: mainProvider.vendorOpeningBalanceController,
                                focusNode: mainProvider.vendorOpeningBalanceFocus,
                                style: GoogleFonts.notoSans(textStyle: TextStyle(color: clblack)),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  labelText: 'Opening Balance ',
                                  labelStyle: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.grey, fontSize: 16)),
                                ),
                              ),
                            ),
                            Consumer<MainProvider>(
                              builder: (context, value, child) => Text(value.vendorOpeningBalanceError.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
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
                            // Cancel action
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
                        child: ElevatedButton(
                          onPressed: () async {
                            if (mainProvider.isLoadingVendorAdding) return;

                            bool isValid = mainProvider.validateVendorForm();

                            if (!isValid) return;

                            bool vendorAddingSuccess = await mainProvider.addVendor(
                              context: context,
                              addedById: loginProvider.usermodel!.userId,
                              addedByName: loginProvider.usermodel!.name,
                            );

                            if (vendorAddingSuccess) {
                              mainProvider.clickAddButton('addPurchase');
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
                              mainProvider.isLoadingVendorAdding
                                  ? SizedBox(height: 24, width: 24, child: const Center(child: CircularProgressIndicator(color: Colors.white)))
                                  : Text("Save", style: TextStyle(color: clwhite, fontSize: 16, fontWeight: FontWeight.w500)),
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
}
