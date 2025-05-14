import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/myColors.dart';
import '../providers/mainProvider.dart';

class ReceiptPortalScreen extends StatelessWidget {
  const ReceiptPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {

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
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD5D7DA)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Receipt Portal',
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color:cl8F1A3F),
                    backgroundColor:  clF4E8EC,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                  ),
                  onPressed: () {
                    // handle navigation
                  },
                  child: Row(
                    children: [
                      Text(
                        'View Ledger',
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color:cl8F1A3F,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Color(0xFF8F1A3F),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Consumer<MainProvider>(
              builder: (context,mainProvider,child) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // Optional: reduce outer padding if not needed
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: mainProvider.borderColor),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: TextField(
                                    focusNode: mainProvider.focusNode,
                                    style:GoogleFonts.notoSans(textStyle:  TextStyle(color: clblack)),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      isDense: true, // Reduces vertical spacing
                                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                      border: InputBorder.none,
                                      label: RichText(
                                        text: TextSpan(
                                          text: 'Ledger ',
                                          style:GoogleFonts.notoSans(textStyle:TextStyle(color: Colors.grey, fontSize: 16) ) ,
                                          children: [
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(color: Colors.red, fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  // Handle tap
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 19.6),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF4E8EC), // background color
                                    border: Border.all(
                                      color: Color(0xFF8F1A3F), // Primary color
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(6), // Optional: Add slight rounding
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.add, color: Color(0xFF8F1A3F), size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        "Create Ledger",
                                        style: TextStyle(
                                          fontFamily: 'Noto Sans',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          height: 1.25, // 20px line-height / 16px font-size
                                          letterSpacing: 0,
                                          color: Color(0xFF8F1A3F),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),


                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            // Optional: reduce outer padding if not needed
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: clF2F2F2,
                              // border: Border.all(color: mainProvider.borderColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              readOnly: true,
                              focusNode: mainProvider.focusNode,
                              style:GoogleFonts.notoSans(textStyle:  TextStyle(color: clblack)),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  labelText: 'Receipt Number  ',
                                  labelStyle:GoogleFonts.notoSans(textStyle:TextStyle(color: Colors.grey, fontSize: 16) )
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // Optional: reduce outer padding if not needed
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: mainProvider.borderColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              focusNode: mainProvider.focusNode,
                              style:GoogleFonts.notoSans(textStyle:  TextStyle(color: clblack)),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true, // Reduces vertical spacing
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                border: InputBorder.none,
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Voucher Number  ',
                                    style:GoogleFonts.notoSans(textStyle:TextStyle(color: Colors.grey, fontSize: 16) ) ,
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            // Optional: reduce outer padding if not needed
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: mainProvider.borderColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              focusNode: mainProvider.focusNode,
                              style:GoogleFonts.notoSans(textStyle:  TextStyle(color: clblack)),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true, // Reduces vertical spacing
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                border: InputBorder.none,
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Date ',
                                    style:GoogleFonts.notoSans(textStyle:TextStyle(color: Colors.grey, fontSize: 16) ) ,
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // Optional: reduce outer padding if not needed
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: mainProvider.borderColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              focusNode: mainProvider.focusNode,
                              style:GoogleFonts.notoSans(textStyle:  TextStyle(color: clblack)),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true, // Reduces vertical spacing
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                border: InputBorder.none,
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Total Amount  ',
                                    style:GoogleFonts.notoSans(textStyle:TextStyle(color: Colors.grey, fontSize: 16) ) ,
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        Expanded(
                          child: Container(
                            // Optional: reduce outer padding if not needed
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: mainProvider.borderColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              focusNode: mainProvider.focusNode,
                              style:GoogleFonts.notoSans(textStyle:  TextStyle(color: clblack)),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true, // Reduces vertical spacing
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                border: InputBorder.none,
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Received Amount  ',
                                    style:GoogleFonts.notoSans(textStyle:TextStyle(color: Colors.grey, fontSize: 16) ) ,
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // Optional: reduce outer padding if not needed
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: clFFEACC,
                              // border: Border.all(color: mainProvider.borderColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              readOnly: true,
                              focusNode: mainProvider.focusNode,
                              style:GoogleFonts.notoSans(textStyle:  TextStyle(color: clblack)),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  isDense: true, // Reduces vertical spacing
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                  border: InputBorder.none,
                                  labelText: 'Balance ',
                                  labelStyle:GoogleFonts.notoSans(textStyle:TextStyle(color: Colors.grey, fontSize: 16) )
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: mainProvider.borderColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: DropdownButtonHideUnderline( // Hides default underline
                              child: DropdownButtonFormField<String>(
                                dropdownColor: clwhite,
                                value: selectedAccount,
                                items: const [
                                  DropdownMenuItem(value: 'Cash in Hand', child: Text('Cash in Hand')),
                                  DropdownMenuItem(value: 'Bank', child: Text('Bank')),
                                ],
                                onChanged: (value) {
                                  selectedAccount = value!;
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                  border: InputBorder.none,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Account ',
                                      style: GoogleFonts.notoSans(
                                        textStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                                      ),
                                      children: const [
                                        TextSpan(
                                          text: '*',
                                          style: TextStyle(color: Colors.red, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                icon: Image.asset('asset/icons/arrowDown.png',scale: 4,),
                                style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(color: clblack, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // Optional: reduce outer padding if not needed
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: mainProvider.borderColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              focusNode: mainProvider.focusNode,
                              style:GoogleFonts.notoSans(textStyle:  TextStyle(color: clblack)),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true, // Reduces vertical spacing
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                                border: InputBorder.none,
                                labelText: 'Narration',
                                labelStyle:GoogleFonts.notoSans(textStyle:TextStyle(color: Colors.grey, fontSize: 16) ) ,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        Expanded(child: SizedBox())
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              // Save action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cl8F1A3F,
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFFD5D7DA), width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                color: clwhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}
