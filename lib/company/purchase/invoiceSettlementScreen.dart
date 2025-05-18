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
                  'Invoice Settlement ',
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
                                label: RichText(
                                  text: TextSpan(
                                    text: 'Invoice Number  ',
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
                          child: Row(
                            children: [
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
                                        labelText: 'Bill Amount ',
                                        labelStyle:GoogleFonts.notoSans(textStyle:TextStyle(color: Colors.grey, fontSize: 16) )
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16,),
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
                            ],
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
                                    text: 'Paid Amount  ',
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
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: mainProvider.borderColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextField(
                                    focusNode: mainProvider.focusNode,
                                    style: GoogleFonts.notoSans(
                                      textStyle: TextStyle(color: Colors.black),
                                    ),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                      border: InputBorder.none,
                                      label: RichText(
                                        text: TextSpan(
                                          text: 'Payment Date ',
                                          style: GoogleFonts.notoSans(
                                            textStyle: TextStyle(color: Colors.grey, fontSize: 16),
                                          ),
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
                                SizedBox(width: 8), // Optional spacing between text field and icon
                                InkWell(
                                  onTap:  () async {
                                    DateTime initialDate =  mainProvider.invoiceAddDate ?? DateTime.now();
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (picked != null) {
                                      mainProvider.setInvoiceAddDate(picked);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Image.asset(
                                      'asset/icons/calenderIcon.png',
                                      scale: 3,
                                    ),
                                  ),
                                ),
                              ],
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
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(width: 16),
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
                              showConfirmPaymentDialog(context);
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

  void showConfirmPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: clwhite,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 500, // Web-specific width
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Confirm Payment",
                        style: GoogleFonts.notoSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// Details Grid
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoItem("Invoice Number", "INV003"),
                            SizedBox(height: 16,),
                            Row(
                              children: [
                                Expanded(child: _buildInfoItem("Bill Amount", "zł1,000")),
                                Expanded(child: _buildInfoItem("Balance", "zł500")),

                              ],
                            ),
                            SizedBox(height: 16,),
                            _buildInfoItem("Paid Amount", "zł500"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoItem("Payment Date", "12-05-2025"),
                            SizedBox(height: 16,),
                            _buildInfoItem("Account", "Cash in Hand"),
                          ],
                        ),
                      )
                    ],
                  ),






                  const SizedBox(height: 30),

                  /// Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
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
                                borderRadius: BorderRadius.circular(10),
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
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              showSuccessDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cl8F1A3F,
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFFD5D7DA), width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Confirm",
                              style: TextStyle(
                                color: clwhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: cl808080,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => InvoiceSettlementScreen(),)
          );
        });

        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: clwhite, // Light green background
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('asset/gif/success.gif',scale: 4,) ,
                const SizedBox(height: 20),
                Flexible(
                  child: Text(
                    'Payment Recorded',
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Flexible(
                  child: Text(
                    'The invoice payment has been completed.',
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: cl808080,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
