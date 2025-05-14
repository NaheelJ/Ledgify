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
        preferredSize: const Size.fromHeight(125),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  child: Icon(
                    CupertinoIcons.back,
                    size: 25,
                    color: Colors.black, // optional
                  ),
                ),
                SizedBox(width: 16,),

                Text(
                  'New Transfer',
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 16),

                // Search Field
                Expanded(
                  child: buildSearchTextField()
                ),

                const SizedBox(width: 16),
                Expanded(child: Consumer<MainProvider>(
                  builder: (context,mainProvider,chid) {
                    return _buildDateBox(imagePath: 'asset/icons/calenderIcon.png', hint: 'Invoice Date', context: context,
                      selectedDate: mainProvider.invoiceDate,
                      onDateSelected: (date) => mainProvider.setInvoiceDate(date),);
                  }
                )),

                const SizedBox(width: 16),

                // Payable Dropdown
                Expanded(child: Consumer<MainProvider>(
                  builder: (context,mainProvider,child) {
                    return _buildDateBox(imagePath: 'asset/icons/calenderIcon.png', hint: 'Due Date', context: context,
                      selectedDate: mainProvider.dueDate,
                      onDateSelected: (date) => mainProvider.setDueDate(date),);
                  }
                )),

                const SizedBox(width: 16),

                // Invoice Date Picker
                Consumer<MainProvider>(
                  builder: (context,mainProvider,child) {
                    return Expanded(
                      child:   _buildDropdown(
                        context,
                        value: mainProvider.priority,
                        items: ['Priority', 'High', 'Medium', 'Low'],
                        onChanged: (val) => mainProvider.setPriority(val!),
                      ),
                    );
                  }
                ),

                const SizedBox(width: 16),

                // Due Date Picker
                Expanded(
                  child: Consumer<MainProvider>(
                    builder: (context,mainProvider,child) {
                      return _buildDropdown(
                        context,
                        value: mainProvider.payable,
                        items: ['Payable', 'Yes', 'No'],
                        onChanged: (val) => mainProvider.setPayable(val!),
                      );
                    }
                  ),
                ),

                const SizedBox(width: 16),

                // Priority Dropdown


                // Apply Button
                SizedBox(
                  width: 150,
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
                    child:  Text(
                      "Apply",
                        style: GoogleFonts.notoSans(
                          textStyle: TextStyle(
                            color: clwhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                  ),
                ),

                const SizedBox(width: 16),

                // Reset Icon
                Image.asset('asset/icons/resetIcon.png',scale: 3.5,),

                const SizedBox(width: 20),


                // PDF Icon
                Image.asset('asset/icons/pdfIcon.png',scale: 3.7,),

                const SizedBox(width: 16),

                // Add Invoice Button
                Expanded(
                  child: SizedBox(
                    width: 150,
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
                      child:  Row(
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
                            )
                          ), Text(
                            "Add Invoice",
                            style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                                color: clwhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
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
                          width: 2200,
                          decoration: BoxDecoration(
                            border: Border.all(color: clE9EAEB), // Outer border
                            borderRadius: BorderRadius.circular(10),),
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Table Header
                                    Container(
                                      width: 2200, // Sum of all column widths
                                      height: 44,
                                      padding: const EdgeInsets.symmetric(horizontal: 10,),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 120,
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
                                            width: 210,
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
                                            width: 210,
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
                                            width: 210,
                                            child: Text(
                                                "Bill Amount",
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
                                            width: 210,
                                            child: Text(
                                                "Hospital Name",
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
                                            width: 210,
                                            child: Text(
                                                "Balance",
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
                                            width: 210,
                                            child: Text(
                                                "Priority",
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
                                            width: 210,
                                            child: Text(
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
                                            width: 210,
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
                                            width: 200,
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
                                            width: 160,
                                            child: Text('View Invoice'),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Table Rows
                                    Column(
                                      children: _buildTravelersPaymentRows(context),
                                    ),
                                  ],
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
                fontSize: 14,
                color: cl666666,
              ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w400,
                fontSize: 14,
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
      padding: const EdgeInsets.symmetric(horizontal: 14),
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
            fontSize: 14,
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
                fontSize: 14,
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
      width: 2200,
      child: Row(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Total : 10',style:  GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
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
List<Widget> _buildTravelersPaymentRows(BuildContext context) {
  var width = MediaQuery.of(context).size.width;

  // Dummy data
  final List<Map<String, String>> dummyList = [
    {
      'slNo': '1',
      'invoiceDate': '12-04-2025',
      'invoiceNumber': 'INV001',
      'billAmount': 'zł1,000',
      'paidAmount': '₹0',
      'balance': '₹1,000',
      'priority': 'High',
      'settlement': 'Settlement',
      'dueDate': '12-05-2025',
      'narration': 'Narration text',
    },
    {
      'slNo': '2',
      'invoiceDate': '11-04-2025',
      'invoiceNumber': 'INV002',
      'billAmount': 'z10,000',
      'paidAmount': '₹0',
      'balance': '₹1,000',
      'priority': 'High',
      'settlement': 'Settlement',
      'dueDate': '11-05-2025',
      'narration': 'Narration text'
    },
    {
      'slNo': '3',
      'invoiceDate': '10-04-2025',
      'invoiceNumber': 'INV003',
      'billAmount': 'zł1,000',
      'paidAmount': '₹0',
      'balance': '₹1,000',
      'priority': 'Medium',
      'settlement': 'Settlement',
      'dueDate': '10-05-2025',
      'narration': 'Narration text'
    },
    {
      'slNo': '4',
      'invoiceDate': '09-04-2025',
      'invoiceNumber': 'INV004',
      'billAmount': 'zł1,000',
      'paidAmount': '₹0',
      'balance': '₹1,000',
      'priority': 'Low',
      'settlement': 'Settlement',
      'dueDate': '09-05-2025',
      'narration': 'Narration text'
    },
    {
      'slNo': '5',
      'invoiceDate': '08-04-2025',
      'invoiceNumber': 'INV005',
      'billAmount': 'zł1,000',
      'paidAmount': 'zł2,500',
      'balance': 'zł1,500',
      'priority': 'High',
      'settlement': 'Settlement',
      'dueDate': '08-05-2025',
      'narration': 'Narration text'
    },
    {
      'slNo': 'Total',
      'invoiceDate': '',
      'invoiceNumber': '',
      'billAmount': 'zł5,000',
      'paidAmount': 'zł2,500',
      'balance': 'zł1,500',
      'priority': '',
      'settlement': '',
      'dueDate': '',
      'narration': ''
    }, {
      'slNo': 'Grand Total',
      'invoiceDate': '',
      'invoiceNumber': '',
      'billAmount': 'zł5,000',
      'paidAmount': 'zł2,500',
      'balance': 'zł1,500',
      'priority': '',
      'settlement': '',
      'dueDate': '',
      'narration': ''
    },
    // Add more items as needed
  ];

  return dummyList.asMap().entries.map((entry) {
    final index = entry.key;
    final item = entry.value;

    return Container(
      width: 2200,
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
            width: 120,
            child: Text(
              item['slNo'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 210,
            child: Text(
              item['invoiceDate'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 210,
            child: Text(
              item['invoiceNumber'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 210,
            child: Text(
              item['billAmount'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 210,
            child: Text(
              item['paidAmount'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 210,
            child: Text(
              item['balance'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 210,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                  BorderRadius.circular(16),
                border: Border.all(width: 1, color: clFD23F6D)
              ),
              child: Center(
                child: Text(
                  item['priority'] ?? '',
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: clblack,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 210,
            child: Center(
              child: SizedBox(
                width: 150,
                height: 32,
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
                    child:  Text(
                        "Settlement ",
                        style: GoogleFonts.notoSans(
                          textStyle: TextStyle(
                            color: clwhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                ),
              ),
            ),
          ),
          SizedBox(
            width: 210,
            child: Text(
              item['dueDate'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              item['narration'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),

          // View Bill Button
          SizedBox(
            width: 160,
            child: InkWell(
              onTap: () {
                // TODO: Implement bill view logic
              },

              child: Center(
                  child: Text(
                    'View Invoice',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: CupertinoColors.systemBlue,
                    ),
                  ),

              ),
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// Reusable text cell builder
Widget _buildCell(String? text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text ?? '',
      style: GoogleFonts.notoSans(
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: clblack,
        ),
      ),
    ),
  );
}
