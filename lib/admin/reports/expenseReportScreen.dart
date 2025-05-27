import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:provider/provider.dart';

class ExpenseReportScreen extends StatelessWidget {
  const ExpenseReportScreen({super.key});

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

                          //  SizedBox(width: 12,),

                          // Title
                          Text(
                            'Expenses Report  ',
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10,),

                          // Search Field
                          SizedBox(
                            width: 280,
                            child: buildSearchTextField(),
                          ),

                          SizedBox(
                            width: 180,
                            child: Consumer<MainProvider>(
                              builder: (context, mainProvider, child) {
                                return _buildDateBox(
                                  imagePath: 'asset/icons/calenderIcon.png',
                                  hint: 'Date',
                                  context: context,
                                  selectedDate: mainProvider.expenseDate,
                                  onDateSelected: (date) => mainProvider.setExpenseDate(date),
                                );
                              },
                            ),
                          ),

                          SizedBox(
                            width: 200,
                            child: Consumer<MainProvider>(
                              builder: (context, mainProvider, child) {
                                return _buildDropdown(
                                  context,
                                  value: mainProvider.company1,
                                  items: ['Company A', 'Company B', 'Company c', 'Company D'],
                                  onChanged: (val) => mainProvider.setCompany1(val!),
                                );
                              },
                            ),
                          ),  SizedBox(
                            width: 250,
                            child: Consumer<MainProvider>(
                              builder: (context, mainProvider, child) {
                                return _buildDropdown(
                                  context,
                                  value: mainProvider.ledger1,
                                  items: ['Krakow Electronics', 'FutureTech Solutions', 'AK Builders', 'Silesia Electronics '],
                                  onChanged: (val) => mainProvider.setLedger1(val!),
                                );
                              },
                            ),
                          ), SizedBox(
                            width: 200,
                            child: Consumer<MainProvider>(
                              builder: (context, mainProvider, child) {
                                return _buildDropdown(
                                  context,
                                  value: mainProvider.group,
                                  items: ['Purchase', 'Sale', 'Rent', 'Purchase '],
                                  onChanged: (val) => mainProvider.setGroup(val!),
                                );
                              },
                            ),
                          ),

                          // Invoice Date




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
                          Image.asset('asset/icons/csvIcon.png', scale: 3.7),

                          // Add Invoice Button

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
                                            width: 100,
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
                                            width: 310,
                                            child: Text(
                                                "Date & Time",
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
                                                "Ledger",
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
                                                "Group",
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
                                                "Account",

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
                                                  "Amount",
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



                                          Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: SizedBox(
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
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Table Rows
                                    Column(
                                      children: _buildExpenceReportRows(context),
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

List<Widget> _buildExpenceReportRows(BuildContext context) {
  var width = MediaQuery.of(context).size.width;

  // Dummy data
  final List<Map<String, String>> dummyList = [
    {

      'dateTime': '28-04-2025 06:00 PM',
      'ledger': 'Krakow Electronics',
      'group': 'Purchase',
      'account': 'Cash in hand',
      'amount': 'zł1,000',
      'narration': 'Narration',
    },
    {

      'dateTime': '28-04-2025 05:00 PM',
      'ledger': 'FutureTech Solutions',
      'group': 'Sale',
      'account': 'PKO Bank',
      'amount': 'zł1,000',
      'narration': 'Narration',
    },
    {

      'dateTime': '28-04-2025 04:00 PM',
      'ledger': 'AK Builders',
      'group': 'Rent',
      'account': 'Bank Pekao',
      'amount': 'zł1,000',
      'narration': 'Narration',
    },
    {

      'dateTime': '28-04-2025 03:00 PM',
      'ledger': 'Silesia Electronics',
      'group': 'Purchase',
      'account': 'Cash in hand',
      'amount': 'zł1,000',
      'narration': 'Narration',
    },
    {

      'dateTime': '28-04-2025 02:00 PM',
      'ledger': 'NextGen',
      'group': 'Sale',
      'account': 'PKO Bank',
      'amount': 'zł1,000',
      'narration': 'Narration',
    },
    {

      'dateTime': '28-04-2025 01:00 PM',
      'ledger': 'Bank Pekao',
      'group': 'Utilities',
      'account': 'Bank Pekao',
      'amount': 'zł1,000',
      'narration': 'Narration',
    },
    {

      'dateTime': '28-04-2025 12:00 AM',
      'ledger': 'Krakow Electronics',
      'group': 'Purchase',
      'account': 'Cash in hand',
      'amount': 'zł1,000',
      'narration': 'Narration',
    },
    {

      'dateTime': '28-04-2025 11:00 AM',
      'ledger': 'Pixco',
      'group': 'Sale',
      'account': 'PKO Bank',
      'amount': 'zł1,000',
      'narration': 'Narration',
    },
    {

      'dateTime': '28-04-2025 10:00 AM',
      'ledger': 'Bank Pekao',
      'group': 'Office Supplies',
      'account': 'Bank Pekao',
      'amount': 'zł1,000',
      'narration': 'Narration',
    },
    {

      'dateTime': '28-04-2025 09:00 AM',
      'ledger': 'Swizz',
      'group': 'Sale',
      'account': 'Cash in hand',
      'amount': 'zł1,000',
      'narration': 'Narration',
    },
  ];

  // Calculate totals

  double amount = 0;

  // Parse and sum all amounts
  for (var item in dummyList) {
    // Extract numeric values from currency strings

    amount += _parseAmount(item['amount'] ?? 'zł0');
  }

  // Format the totals back to currency strings

  String formattedAmount = 'zł${_formatAmount(amount)}';

  // Create a list that includes the original items plus the totals
  List<Widget> rows = [];

  // Add regular data rows
  for (int i = 0; i < dummyList.length; i++) {
    final item = dummyList[i];
    rows.add(_buildRow(
      index: i,
      item: item,
      isEven: i.isEven,
      isTotal: false,
      isGrandTotal: false,
    ));
  }

  // Add Total row
  rows.add(_buildRow(
    index: dummyList.length,
    item: {
      'dateTime': '',
      'ledger': '',
      'group': '',
      'account': '',
      'amount': formattedAmount,
      'narration': '',
    },
    isEven: dummyList.length.isEven,
    isTotal: true,
    isGrandTotal: false,
  ));

  // Add Grand Total row (in this case, it's the same as the total,
  // but you could have different calculations if needed)
  rows.add(_buildRow(
    index: dummyList.length + 1,
    item: {
      'dateTime': '',
      'ledger': '',
      'group': '',
      'account': '',
      'amount': formattedAmount,
      'narration': '',
    },
    isEven: (dummyList.length + 1).isEven,
    isTotal: false,
    isGrandTotal: true,
  ));

  return rows;
}

// Helper function to build each row
Widget _buildRow({
  required int index,
  required Map<String, String> item,
  required bool isEven,
  required bool isTotal,
  required bool isGrandTotal,
}) {
  String slNo = '';

  if (isTotal) {
    slNo = 'Total';
  } else if (isGrandTotal) {
    slNo = 'Grand Total';
  } else {
    slNo = (index + 1).toString();
  }

  return Container(
    width: 2500,
    height: 40,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: isTotal || isGrandTotal ? clF2F2F2 : isEven ? clwhite : clFAFAFA,
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
          width: 100,
          child: Text(
            slNo, // Display sl no or Total/Grand Total text
            style: GoogleFonts.notoSans(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: isTotal || isGrandTotal ? FontWeight.w400 : FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 310,
          child: Text(
            item['dateTime'] ?? '',
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
          width: 310,
          child: Text(
            item['ledger'] ?? '',
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
            item['group'] ?? '',
            style: GoogleFonts.notoSans(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: isTotal || isGrandTotal ? FontWeight.w600 : FontWeight.w400,
                color: clblack,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Text(
            item['account'] ?? '',
            style: GoogleFonts.notoSans(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: isTotal || isGrandTotal ? FontWeight.w400 : FontWeight.w400,
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
              item['amount'] ?? '',
              textAlign: TextAlign.end,
              style: GoogleFonts.notoSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: isTotal || isGrandTotal ? FontWeight.w400 : FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
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
        ),

      ],
    ),
  );
}

// Helper function to parse currency amounts
double _parseAmount(String amount) {
  // Remove currency symbol and commas, then parse to double
  String numericString = amount.replaceAll('zł', '').replaceAll(',', '');
  return double.tryParse(numericString) ?? 0.0;
}

// Helper function to format amounts with thousand separators
String _formatAmount(double amount) {
  // Format with thousand separators
  final formatter = NumberFormat('#,###', 'en_US');
  return formatter.format(amount);
}
