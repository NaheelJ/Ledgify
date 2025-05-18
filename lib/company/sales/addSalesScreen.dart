import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants/myColors.dart';
import '../../providers/mainProvider.dart';

class AddSalesScreen extends StatelessWidget {
  const AddSalesScreen({super.key});

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
                Row(
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
                      'Add Sales Entry',
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color:cl8F1A3F),
                    backgroundColor:  clF4E8EC,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
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
                final hasImage = mainProvider.invoiceImage != null;

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
                                          text: 'Customer ',
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
                                        "Add Customer",
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
                                    text: 'Invoice Number ',
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
                                          text: 'Invoice Date ',
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

                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: mainProvider.borderColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Total Amount ',
                                    style: GoogleFonts.notoSans(
                                      textStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 24,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        color: clF2F2F2,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 8,),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          dropdownColor: Colors.white,
                                          icon: Image.asset('asset/icons/arrowDown.png',scale: 6,),
                                          value: mainProvider.selectedCurrency, // e.g., "zł"
                                          items: ['zł', '€']
                                              .map((currency) => DropdownMenuItem<String>(
                                            value: currency,
                                            child: Text(currency),
                                          ))
                                              .toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              mainProvider.setCurrency(value); // your method to update state
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        focusNode: mainProvider.billAmount2FocusNode,
                                        keyboardType: TextInputType.number,
                                        style: GoogleFonts.notoSans(
                                          textStyle: TextStyle(color: Colors.black),
                                        ),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                          border: InputBorder.none,
                                          hintText: "${mainProvider.selectedCurrency}0.00", // optional
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                                    text: 'Received Amount ',
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
                                  labelText: 'Balance',
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
                                  child: TextFormField(
                                    controller: mainProvider.dueDateController,
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
                                          text: 'Due Date ',
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
                                Consumer<MainProvider>(
                                    builder: (context, mainProvider, child) {
                                      return InkWell(
                                        onTap: () async {
                                          DateTime initialDate = mainProvider.dueAddDate ?? DateTime.now();
                                          DateTime? picked = await showDatePicker(
                                            context: context,
                                            initialDate: initialDate,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                          );
                                          if (picked != null) {
                                            mainProvider.setDueAddDate(picked);
                                            mainProvider.dueDateController.text = '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Image.asset(
                                            'asset/icons/calenderIcon.png',
                                            scale: 3,
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                        Expanded(
                            child: DottedBorder(
                              color: clCCCCCC,
                              strokeWidth: 1,
                              dashPattern: [7, 9],
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              child: GestureDetector(
                                onTap: () {
                                  if (!hasImage) {
                                    mainProvider.showImagePicker(context,);
                                  }
                                },
                                child:Container(
                                  height: 80,
                                  width: width,
                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                                  color: clF4E8EC,
                                  child: mainProvider.invoiceImage != null
                                      ? Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          mainProvider.invoiceImage!,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: IconButton(
                                          icon: const Icon(Icons.close, color: Colors.red),
                                          onPressed: () {
                                            mainProvider.clearImageInInvoiceImage();
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                      : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Upload Invoice",
                                        style: GoogleFonts.openSans(
                                          fontSize: 16,
                                          color: cl8F1A3F,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Supported formats: JPEG, PNG, PDF",
                                        style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          color: cl808080,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))


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
                        "Confirm Sales Entry",
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
                            _buildInfoItem("Customer", "Krakow Tech Innovations"),
                            SizedBox(height: 16,),
                            _buildInfoItem("Invoice Date", "12-05-2025"),
                            SizedBox(height: 16,),
                            _buildInfoItem("Received  Amount ", "zł1,000"),
                            SizedBox(height: 16,),
                            _buildInfoItem("Account", "Cash in Hand"),
                            SizedBox(height: 16,),
                            _buildInfoItem("Narration ", "Narration"),
                          ],
                        ),
                      ),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoItem("Invoice Number ", "INV003"),
                            SizedBox(height: 16,),
                            _buildInfoItem("Total Amount ", "zł1,000"),
                            SizedBox(height: 16,),
                            _buildInfoItem("Balance", "zł500"),
                            SizedBox(height: 16,),
                            _buildInfoItem("Due Date", "12-05-2025"),
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
      width: 260,
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
        Future.delayed(const Duration(seconds: 4), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AddSalesScreen(),)
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
                Image.asset('asset/gif/success.gif',scale: 1.5,) ,
                const SizedBox(height: 18),
                Flexible(
                  child: Text(
                    ' Sales Entry Added',
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Flexible(
                  child: Text(
                    'The invoice has been successfully recorded',
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




