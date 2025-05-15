

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:provider/provider.dart';
class InternalTransferScreen extends StatelessWidget {
  const InternalTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define controllers outside of the build method but inside the class
    final TextEditingController controllerNew = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: clwhite,
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Internal Transfer',
                                style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 16),

                              Consumer<MainProvider>(
                                builder: (context, mainProvider, child) {
                                  return _buildDateBox(
                                    imagePath: 'asset/icons/calenderIcon.png',
                                    hint: 'Select date',
                                    context: context,
                                    selectedDate: mainProvider.internalTransferDate,
                                    onDateSelected: (date) =>
                                        mainProvider.setInternalTransferDate(date),
                                  );
                                },
                              ),

                              const SizedBox(width: 16),

                              Consumer<MainProvider>(
                                builder: (context, mainProvider, child) {
                                  return _buildDropdown(
                                    context,
                                    value: mainProvider.sourceAccount,
                                    items: [
                                      'Source Account',
                                      'Cash in hand',
                                      'PKO Bank',
                                      'Bank Pekao    '
                                    ],
                                    onChanged: (val) => mainProvider.setSourceAccount(val!),
                                  );
                                },
                              ),

                              const SizedBox(width: 16),

                              Consumer<MainProvider>(
                                builder: (context, mainProvider, child) {
                                  return _buildDropdown(
                                    context,
                                    value: mainProvider.desigAccount,
                                    items: ['Destination Account', 'Cash in hand', 'PKO Bank'],
                                    onChanged: (val) => mainProvider.setDesignAccount(val!),
                                  );
                                },
                              ),

                              const SizedBox(width: 16),

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
                                    side: const BorderSide(
                                        color: Color(0xFFD5D7DA), width: 1),
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

                              const SizedBox(width: 16),

                              Image.asset('asset/icons/resetIcon.png', scale: 3.5),
                            ],
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 180,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {

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
                                child:  FittedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "+ ",
                                          style: GoogleFonts.notoSans(
                                            textStyle: TextStyle(
                                              color: clwhite,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          )
                                      ), Text(
                                          "New Transfer",
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: 1900,
                      decoration: BoxDecoration(
                        border: Border.all(color: clE9EAEB), // Outer border
                        borderRadius: BorderRadius.circular(10),),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Table Header
                                Container(
                                  width: 1900, // Sum of all column widths
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
                                        width: 160,
                                        child: Text(
                                            "Date",
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
                                        width: 380,
                                        child: Text(
                                            "Source Account",
                                            style: GoogleFonts.notoSans(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: clblack
                                              ),
                                            )
                                        ),
                                      ), SizedBox(
                                        width: 380,
                                        child: Text(
                                            "Destination Account",
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
                                        width: 220,
                                        child: Text(
                                            "Amount",
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
                                        width: 240,
                                        child: Text(
                                            "Source A/C Balance ",
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
          icon: Row(
            children: [
              SizedBox(width: 8,),
              Image.asset('asset/icons/arrowDown.png',scale: 4,),
            ],
          ),
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
          firstDate: DateTime(1900),
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



  Widget buildPagination() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: 1900,
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
List<Widget> _buildTravelersPaymentRows(BuildContext context) {
  var width = MediaQuery.of(context).size.width;

  // Dummy data
  final List<Map<String, String>> dummyList = [
    {
      'slNo': '1',
      'date': '12-04-2025',
      'sourceAccount': 'Cash in hand',
      'designationAccount': 'PKO Bank',
      'amount': 'zł1,000',
      'balance': '€30,500',
      'narration': 'Narration',
    },
    {
      'slNo': '2',
      'date': '11-04-2025',
      'sourceAccount': 'PKO Bank',
      'designationAccount': 'Bank Pekao',
      'amount': 'zł500',
      'balance': '€25,500',
      'narration': 'Narration',
    },
    {
      'slNo': '3',
      'date': '10-04-2025',
      'sourceAccount': 'Bank Pekao',
      'designationAccount': 'Cash in hand',
      'amount': 'zł500',
      'balance': '€20,000',
      'narration': 'Narration',
    },
    {
      'slNo': '4',
      'date': '09-04-2025',
      'sourceAccount': 'Cash in hand',
      'designationAccount': 'PKO Bank',
      'amount': 'zł2,000',
      'balance': '€18,500',
      'narration': 'Narration',
    },
    {
      'slNo': '5',
      'date': '08-04-2025',
      'sourceAccount': 'PKO Bank',
      'designationAccount': 'Bank Pekao',
      'amount': 'zł1,000',
      'balance': '€40,500',
      'narration': 'Narration',
    },
  ];

  return dummyList.asMap().entries.map((entry) {
    final index = entry.key;
    final item = entry.value;
    bool isTotal = item['slNo'] == 'Total' || item['slNo'] == 'Grand Total';

    return Container(
      width: 1900,
      height: 40,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isTotal ? clF2F2F2 :index.isEven ? clwhite : clFAFAFA,
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
              item['slNo'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              item['date'] ?? '',
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
            width: 380,
            child: Text(
              item['sourceAccount'] ?? '',
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
            width: 380,
            child: Text(
              item['designationAccount'] ?? '',
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
            width: 220,
            child: Text(
              item['amount'] ?? '',
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
            width: 240,
            child: Text(
              item['balance'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              item['narration'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),

          // View transaction button (only for regular rows, not totals)
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
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: clblack,
        ),
      ),
    ),
  );
}
