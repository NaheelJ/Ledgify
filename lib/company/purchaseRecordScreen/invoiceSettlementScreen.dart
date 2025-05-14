import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants/myColors.dart';
import '../../providers/mainProvider.dart';

class InvoiceSettlementScreen extends StatelessWidget {
  const InvoiceSettlementScreen({super.key});

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
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: clwhite, // or Colors.white
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFEBEBEB),
                      width: 0.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x14000000),
                        blurRadius: 16,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child:  Icon(
                    CupertinoIcons.back,
                    size: 24,
                    color: Colors.black, // optional
                  ),
                ),
                SizedBox(width: 12,),

                Text(
                  'Add Purchase Invoice',
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: Colors.black,
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
                                    text: 'Source Account ',
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
                                      text: 'Destination Account ',
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
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Amount  ',
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
                                  labelText: 'Source Account Balance ',
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
                                labelText: 'Narration',
                                labelStyle:GoogleFonts.notoSans(textStyle:TextStyle(color: Colors.grey, fontSize: 16) ) ,
                              ),
                            ),
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
