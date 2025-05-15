import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:provider/provider.dart';

class SalesRecordScreen extends StatelessWidget {
  const SalesRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define controllers outside of the build method but inside the class
    final TextEditingController controllerNew = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: clwhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD5D7DA)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: IntrinsicWidth(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.start,
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
                          //  SizedBox(width: 12,),

                          // Title
                          Text(
                            'Sales Records',
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10,),

                          // Search Field
                          SizedBox(
                            width: 200,
                            child: buildSearchTextField(),
                          ),

                          // Invoice Date
                          SizedBox(
                            width: 180,
                            child: Consumer<MainProvider>(
                              builder: (context, mainProvider, child) {
                                return _buildDateBox(
                                  imagePath: 'asset/icons/calenderIcon.png',
                                  hint: 'Invoice Date',
                                  context: context,
                                  selectedDate: mainProvider.invoiceSalesDate,
                                  onDateSelected: (date) => mainProvider.setInvoiceSalesDate(date),
                                );
                              },
                            ),
                          ),

                          // Due Date
                          SizedBox(
                            width: 180,
                            child: Consumer<MainProvider>(
                              builder: (context, mainProvider, child) {
                                return _buildDateBox(
                                  imagePath: 'asset/icons/calenderIcon.png',
                                  hint: 'Due Date',
                                  context: context,
                                  selectedDate: mainProvider.dueSalesDate,
                                  onDateSelected: (date) => mainProvider.setDueSalesDate(date),
                                );
                              },
                            ),
                          ),

                          // Priority Dropdown
                          SizedBox(
                            width: 150,
                            child: Consumer<MainProvider>(
                              builder: (context, mainProvider, child) {
                                return _buildDropdown(
                                  context,
                                  value: mainProvider.receivables,
                                  items: ['Receivables', 'a', 'b', 'c'],
                                  onChanged: (val) => mainProvider.setReceivables(val!),
                                );
                              },
                            ),
                          ),

                          // Apply Button
                          SizedBox(
                            width: 100,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                // Save action
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
                              child: Text(
                                "Apply",
                                style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                    color: clwhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Reset Icon
                          Image.asset('asset/icons/resetIcon.png', scale: 3.5),

                          // PDF Icon
                          Image.asset('asset/icons/pdfIcon.png', scale: 3.7),

                          // Add Invoice Button
                          SizedBox(
                            width: 180,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add Invoice action
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "+ ",
                                    style: GoogleFonts.notoSans(
                                      textStyle: TextStyle(
                                        color: clwhite,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Add Sales",
                                    style: GoogleFonts.notoSans(
                                      textStyle: TextStyle(
                                        color: clwhite,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),


      body: Column(
        children: [

          // Table content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: 2500,
                      height: height/1.17,
                      decoration: BoxDecoration(
                        border: Border.all(color: clE9EAEB), // Outer border
                        borderRadius: BorderRadius.circular(10),),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Table Header
                                    Container(
                                      width: 2500, // Sum of all column widths
                                      height: 44,
                                      padding: const EdgeInsets.symmetric(horizontal: 10,),
                                      decoration: BoxDecoration(
                                        border: const Border(
                                          bottom: BorderSide(
                                            color: clE9EAEB,
                                            width: 1,
                                          ),
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 90,
                                            child: Text(
                                                "Sl.No",
                                                style: GoogleFonts.notoSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: clblack
                                                  ),
                                                )
                                            ),
                                          ),
                                          SizedBox(
                                            width: 190,
                                            child: Text(
                                                "Invoice Date",
                                                style: GoogleFonts.notoSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: clblack
                                                  ),
                                                )
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                                "Invoice Number",
                                                style: GoogleFonts.notoSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: clblack
                                                  ),
                                                )
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                                "Total Amount",
                                                textAlign: TextAlign.end,
                                                style: GoogleFonts.notoSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: clblack
                                                  ),
                                                )
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                                "Paid Amount",
                                                textAlign: TextAlign.end,
                              
                                                style: GoogleFonts.notoSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: clblack
                                                  ),
                                                )
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 16),
                                            child: SizedBox(
                                              width: 200,
                                              child: Text(
                                                  "Balance",
                                                  textAlign: TextAlign.end,
                              
                                                  style: GoogleFonts.notoSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: clblack
                                                    ),
                                                  )
                                              ),
                                            ),
                                          ),
                              
                              
                                          SizedBox(
                                            width: 190,
                                            child: Text(
                                                textAlign: TextAlign.center,
                                                "Settlement",
                                                style: GoogleFonts.notoSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: clblack
                                                  ),
                                                )
                                            ),
                                          ),
                              
                                          SizedBox(
                                            width: 310,
                                            child: Text(
                                                "Customer Name",
                                                style: GoogleFonts.notoSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: clblack
                                                  ),
                                                )
                                            ),
                                          ),
                              
                                          SizedBox(
                                            width: 180,
                                            child: Text(
                                                "Narration",
                                                style: GoogleFonts.notoSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: clblack
                                                  ),
                                                )
                                            ),
                                          ),
                                          SizedBox(
                                            width: 190,
                                            child: Text(
                                                "Due Date",
                                                style: GoogleFonts.notoSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: clblack
                                                  ),
                                                )
                                            ),
                                          ),
                                          SizedBox(
                                            width: 180,
                                            child: Text('View Invoice',
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.notoSans(
                              
                              
                                                    textStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: clblack
                                                    ))),
                                          ),
                                        ],
                                      ),
                                    ),
                              
                                    // Table Rows
                                    Column(
                                      children: _buildPurchaseRecordRows(context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          buildPagination(),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchTextField() {
    return Container(
      height: 45,
      width: 200, // Adjust width as needed
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: clFAFAFA, // Light background
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset('asset/icons/searchIcon.png',scale: 4,),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle:  GoogleFonts.notoSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: cl666666,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: cl666666,
              ),
            ),
          ),
        ],
      ),
    );
  }

// dropdown
  Widget _buildDropdown(
      BuildContext context, {
        required String value,
        required List<String> items,
        required ValueChanged<String?> onChanged,
      }) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: clFAFAFA,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: clwhite,
          value: value,
          icon: Image.asset('asset/icons/arrowDown.png',scale: 4,),
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: cl666666,
          ),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDateBox({
    required BuildContext context,
    required String imagePath,
    required String hint,
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    return GestureDetector(
      onTap: () async {
        DateTime initialDate = selectedDate ?? DateTime.now();
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: clFAFAFA,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null
                  ? '${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}'
                  : hint,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: cl666666,
              ),
            ),
            const SizedBox(width: 6),
            Image.asset(imagePath, scale: 3.5),
          ],
        ),
      ),
    );
  }


  Widget _buildDateField(String label, bool isFromDate) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: clwhite,
      ),

    );
  }

  Widget buildPagination() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: 2500,
      child: Row(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Total : 10',style:  GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: cl666666,
              ),)),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,width: 500,
                /* decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1F000000),
                      offset: Offset(0, -1),
                      blurRadius: 16.6,
                    ),
                  ],
                ),*/
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Previous button
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: clD5D7DA,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.black, size: 18),
                    ),

                    // Scrollable pagination numbers
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 1; i <= 6; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side:  BorderSide(color:i == 3 ?  Colors.grey:clwhite), // Border color
                                  ),
                                  minimumSize: const Size(40, 40),
                                ),
                                child: Text(
                                  '$i',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: clblack,
                                      fontWeight:i == 3 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Next button
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),

                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: clD5D7DA,
                          width:0.5,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Icon(Icons.arrow_forward, color: Colors.black, size: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }}

List<Widget> _buildPurchaseRecordRows(BuildContext context) {
  var width = MediaQuery.of(context).size.width;

  // Dummy data
  final List<Map<String, String>> dummyList = [
    {
      'invoiceDate': '12-04-2025',
      'invoiceNumber': 'INV001',
      'totalAmount': 'zł1,000',
      'paidAmount': 'zł0',
      'balance': 'zł1,000',
      'settlement': 'Settlement',
      'customerName': 'Krakow Electronics',
      'narration': 'Narration',
      'dueDate': '12-05-2025',

    },
    {
      'invoiceDate': '11-04-2025',
      'invoiceNumber': 'INV002',
      'totalAmount': 'zł1,000',
      'paidAmount': 'zł0',
      'balance': 'zł1,000',

      'settlement': 'Settlement',
      'customerName': 'Wawel Electronics Services',
      'narration': 'Narration',
      'dueDate': '11-05-2025',
    },
    {
      'invoiceDate': '10-04-2025',
      'invoiceNumber': 'INV003',
      'totalAmount': 'zł1,000',
      'paidAmount': 'zł0',
      'balance': 'zł1,000',
      'settlement': 'Settlement',
      'customerName': 'Vistula Electronics',
      'narration': 'Narration',
      'dueDate': '10-05-2025',

    },
    {
      'invoiceDate': '09-04-2025',
      'invoiceNumber': 'INV004',
      'totalAmount': 'zł1,000',
      'paidAmount': 'zł0',
      'balance': 'zł1,000',
      'settlement': 'Settlement',
      'customerName': 'Polish Electronics Hub',
      'narration': 'Narration',
      'dueDate': '09-05-2025',


    },
  ];

  return dummyList.asMap().entries.map((entry) {
    final index = entry.key;
    final item = entry.value;

    // Auto-generate slNo based on index for regular rows
    String slNo = '';
    if (index < 10) {
      // Regular row
      slNo = (index + 1).toString();
    } else if (index == 10) {
      // Total row
      slNo = 'Total';
    } else if (index == 11) {
      // Grand Total row
      slNo = 'Grand Total';
    }

    final bool isTotal = index >= 10;
    return Container(
      width: 2500,
      height: 40,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: index.isEven ? clwhite : clFAFAFA,
        border: const Border(
          bottom: BorderSide(
            color: clE9EAEB,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              slNo,
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 190,
            child: Text(
              item['invoiceDate'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              item['invoiceNumber'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(

              item['totalAmount'] ?? '',
              textAlign: TextAlign.end,
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              textAlign: TextAlign.end,

              item['paidAmount'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 200,
              child: Text(
                textAlign: TextAlign.end,

                item['balance'] ?? '',
                style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: clblack,
                  ),
                ),
              ),
            ),
          ),


          SizedBox(
            width: 190,
            child: !isTotal ? Padding(
              padding: const EdgeInsets.symmetric(horizontal:12),
              child: Center(
                child: SizedBox(
                  width: 150,
                  height: 32,
                  child: ElevatedButton(
                      onPressed: () {
                        // Settlement action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8F1A3F), // Maroon color from the image
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                          "Settlement",
                          style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                      )
                  ),
                ),
              ),
            ) : SizedBox(),
          ),

          SizedBox(
            width: 310,
            child: Text(
              item['customerName'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: Text(
              item['narration'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 190,
            child: Text(
              item['dueDate'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),


          // View Invoice Button
          SizedBox(
            width: 180,
            child: !isTotal ? InkWell(
              onTap: () {
                // Implement invoice view logic
              },
              child: Text(
                'View Invoice',
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: cl5856D6,
                    decoration: TextDecoration.underline,
                    decorationColor: cl5856D6
                ),
              ),
            ) : SizedBox(),
          ),
        ],
      ),
    );
  }).toList();
}

