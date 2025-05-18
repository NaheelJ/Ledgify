import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:provider/provider.dart';

class PurchaseRecordScreen extends StatelessWidget {
  const PurchaseRecordScreen({super.key});

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
                            'Purchase Records',
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
                                  selectedDate: mainProvider.invoiceDate,
                                  onDateSelected: (date) => mainProvider.setInvoiceDate(date),
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
                                  selectedDate: mainProvider.dueDate,
                                  onDateSelected: (date) => mainProvider.setDueDate(date),
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
                                  value: mainProvider.priority,
                                  items: ['Priority', 'High', 'Medium', 'Low'],
                                  onChanged: (val) => mainProvider.setPriority(val!),
                                );
                              },
                            ),
                          ),

                          // Payable Dropdown
                          SizedBox(
                            width: 150,
                            child: Consumer<MainProvider>(
                              builder: (context, mainProvider, child) {
                                return _buildDropdown(
                                  context,
                                  value: mainProvider.payable,
                                  items: ['Payable', 'Yes', 'No'],
                                  onChanged: (val) => mainProvider.setPayable(val!),
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
                                    "Add Purchase",
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
                                                  "Bill Amount",
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
                                            SizedBox(
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
                                            Padding(
                                              padding: const EdgeInsets.only(left: 30),
                                              child: SizedBox(
                                                width: 310,
                                                child: Text(
                                                    "Vendor Name",
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
                                              width: 100,
                                              child: Text(
                                                  "Priority",
                                                  textAlign: TextAlign.center,
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
        'billAmount': 'zł1,000',
        'paidAmount': 'zł0',
        'balance': 'zł1,000',
        'priority': 'High',
        'settlement': 'Settlement',
        'dueDate': '12-05-2025',
        'narration': 'Narration',
        'vendorName': 'Krakow Electronics',
      },
      {
        'invoiceDate': '11-04-2025',
        'invoiceNumber': 'INV002',
        'billAmount': 'zł1,000',
        'paidAmount': 'zł0',
        'balance': 'zł1,000',
        'priority': 'High',
        'settlement': 'Settlement',
        'dueDate': '11-05-2025',
        'narration': 'Narration',
        'vendorName': 'Wawel Electronics Services',
      },
      {
        'invoiceDate': '10-04-2025',
        'invoiceNumber': 'INV003',
        'billAmount': 'zł1,000',
        'paidAmount': 'zł0',
        'balance': 'zł1,000',
        'priority': 'High',
        'settlement': 'Settlement',
        'dueDate': '10-05-2025',
        'narration': 'Narration',
        'vendorName': 'Vistula Electronics',
      },
      {
        'invoiceDate': '09-04-2025',
        'invoiceNumber': 'INV004',
        'billAmount': 'zł1,000',
        'paidAmount': 'zł0',
        'balance': 'zł1,000',
        'priority': 'High',
        'settlement': 'Settlement',
        'dueDate': '09-05-2025',
        'narration': 'Narration',
        'vendorName': 'Polish Electronics Hub',
      },
      {
        'invoiceDate': '08-04-2025',
        'invoiceNumber': 'INV005',
        'billAmount': 'zł1,000',
        'paidAmount': 'zł0',
        'balance': 'zł1,000',
        'priority': 'High',
        'settlement': 'Settlement',
        'dueDate': '08-05-2025',
        'narration': 'Narration',
        'vendorName': 'Warsaw Electronics Agency',
      },
      {
        'invoiceDate': '07-04-2025',
        'invoiceNumber': 'INV006',
        'billAmount': 'zł1,000',
        'paidAmount': 'zł500',
        'balance': 'zł500',
        'priority': 'Medium',
        'settlement': 'Settlement',
        'dueDate': '07-05-2025',
        'narration': 'Narration',
        'vendorName': 'Gdansk Electronics',
      },
      {
        'invoiceDate': '06-04-2025',
        'invoiceNumber': 'INV007',
        'billAmount': 'zł1,000',
        'paidAmount': 'zł500',
        'balance': 'zł500',
        'priority': 'Medium',
        'settlement': 'Settlement',
        'dueDate': '06-05-2025',
        'narration': 'Narration',
        'vendorName': 'Silesia Electronics',
      },
      {
        'invoiceDate': '05-04-2025',
        'invoiceNumber': 'INV008',
        'billAmount': 'zł1,000',
        'paidAmount': 'zł500',
        'balance': 'zł500',
        'priority': 'Medium',
        'settlement': 'Settlement',
        'dueDate': '05-05-2025',
        'narration': 'Narration',
        'vendorName': 'Lublin Electronics Partners',
      },
      // Add more items as needed
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

                item['billAmount'] ?? '',
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
            SizedBox(
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
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: SizedBox(
                width: 310,
                child: Text(
                  item['vendorName'] ?? '',
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
              width: 100,
              child: !isTotal ? Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _getBorderColor(item['priority']),width: 0.5),
                  color: _getPriorityColor(item['priority']),
                ),
                child: Center(
                  child: Text(
                    item['priority'] ?? '',
                    style: GoogleFonts.notoSans(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _getPriorityTextColor(item['priority']),
                      ),
                    ),
                  ),
                ),
              ) : SizedBox(),
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
                            borderRadius: BorderRadius.circular(8),
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

// Helper function to get appropriate background color for priority
Color _getPriorityColor(String? priority) {
  switch (priority) {
    case 'High':
      return const Color(0xFFFFF5F5); // Light red background
    case 'Medium':
      return const Color(0xFFFFFBF5); // Light orange/yellow background
    case 'Low':
      return const Color(0xFFEFFBF2); // Light green background
    default:
      return Colors.transparent;
  }
}

Color _getBorderColor(String? priority) {
  switch (priority) {
    case 'High':
      return const Color(0xFFFFBBB8); // Light red background
    case 'Medium':
      return const Color(0xFFFFDFB8); // Light orange/yellow background
    case 'Low':
      return const Color(0xFFC6F1D1); // Light green background
    default:
      return Colors.transparent;
  }
}

// Helper function to get appropriate text color for priority
Color _getPriorityTextColor(String? priority) {
  switch (priority) {
    case 'High':
      return const Color(0xFFFF4D4D); // Red text
    case 'Medium':
      return const Color(0xFFFFAA00); // Orange text
    case 'Low':
      return const Color(0xFF66CC66); // Green text
    default:
      return clblack;
  }
}
// Reusable text cell builder
Widget _buildCell(String? text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text ?? '',
      style: GoogleFonts.notoSans(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: clblack,
        ),
      ),
    ),
  );
}
