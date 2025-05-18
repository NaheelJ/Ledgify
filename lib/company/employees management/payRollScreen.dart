import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:provider/provider.dart';

class PayRollScreen extends StatelessWidget {
  const PayRollScreen({super.key});

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
                          // Title
                          Text(
                            'Payroll',
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
                                  hint: 'Date',
                                  context: context,
                                  selectedDate: mainProvider.payRollDate,
                                  onDateSelected: (date) => mainProvider.setPayRollDate(date),
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
                          Consumer<MainProvider>(
                            builder: (context, mainProvider, child) => SizedBox(
                              width: 180,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await mainProvider.pickExcelFile();
                                  if (mainProvider.selectedFile != null) {
                                    // Do something with the file
                                    print('Excel file picked: ${mainProvider.selectedFile!.path}');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: clF4E8EC,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('asset/icons/uploadExcelIcon.png', scale: 4),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Upload Excel",
                                      style: GoogleFonts.notoSans(
                                        textStyle: const TextStyle(
                                          color: cl8F1A3F,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )

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
                      width: 1800,
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
                                    width: 1800, // Sum of all column widths
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
                                          width: 280,
                                          child: Text(
                                              "Name",
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
                                          width: 280,
                                          child: Text(
                                              "Surname",
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
                                              "Employee ID",
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
                                              textAlign: TextAlign.center,

                                              "Salary Payable",

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
                                              "1st Release",
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
                                        Padding(
                                          padding: const EdgeInsets.only(left: 30),
                                          child: SizedBox(
                                            width: 140  ,
                                            child: Text(
                                                "2nd Release",
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
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Table Rows
                                  Column(
                                    children: _buildPayRollListRows(context),
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
      width: 1800,
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

List<Widget> _buildPayRollListRows(BuildContext context) {
  var width = MediaQuery.of(context).size.width;

  // Dummy data
  final List<Map<String, String>> dummyList = [
    {
      'name': 'Kacper',
      'surname': 'Kacprzak',
      'employeeId': 'XY98765',
      'salaryPayable': 'zł1,500',
      'firstRelease': 'zł750',
      'secondRelease': 'zł750',
    },
    {
      'name': 'Marek',
      'surname': 'Marekowski',
      'employeeId': 'AB54321',
      'salaryPayable': 'zł1,500',
      'firstRelease': 'zł750',
      'secondRelease': 'zł750',
    },
    {
      'name': 'Tomasz',
      'surname': 'Tomaszewski',
      'employeeId': 'CD67890',
      'salaryPayable': 'zł1,500',
      'firstRelease': 'zł750',
      'secondRelease': 'zł750',
    },
    {
      'name': 'Jakub',
      'surname': 'Jakubowicz',
      'employeeId': 'EF13579',
      'salaryPayable': 'zł1,500',
      'firstRelease': 'zł750',
      'secondRelease': 'zł750',
    },
    {
      'name': 'Szymon',
      'surname': 'Szymonowicz',
      'employeeId': 'GH24680',
      'salaryPayable': 'zł1,500',
      'firstRelease': 'zł750',
      'secondRelease': 'zł750',
    },
    {
      'slNo': 'Total',
      'salaryPayable': 'zł16,500',
      'firstRelease': 'zł3,750',
      'secondRelease': 'zł3,750',
    },
    {
      'slNo': 'Grand Total',
      'salaryPayable': 'zł33,000',
      'firstRelease': 'zł16,500',
      'secondRelease': 'zł16,500',
    },
  ];

  return dummyList.asMap().entries.map((entry) {
    final index = entry.key;
    final item = entry.value;

    final String slNo = item['slNo'] ?? (index + 1).toString();

    return Container(
      width: 1800,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: slNo=='Total'||slNo=='Grand Total'?clF2F2F2:index.isEven ? clwhite : clFAFAFA,
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
              slNo,
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 280,
            child: Text(
              item['name'] ?? '',
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
            width: 280,
            child: Text(
              item['surname'] ?? '',
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
              item['employeeId'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: clblack,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),

            decoration: BoxDecoration(
              color: slNo=='Total'||slNo=='Grand Total'?clF2F2F2: clwhite ,
              border: Border(right: BorderSide( color: clE9EAEB,
                width: 0.7,),left: BorderSide( color: clE9EAEB,
                width: 1,)

              ),
            ),
            height: 40,
            width: 200,
            child: TextFormField(
              initialValue:item['salaryPayable'] ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: clblack),
              ),
              decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
              onChanged: (value) {

              },
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 10),

            decoration: BoxDecoration(
              color: slNo=='Total'||slNo=='Grand Total'?clF2F2F2: clwhite ,
              border: Border(right: BorderSide( color: clE9EAEB,
                width: 0.7,),left: BorderSide( color: clE9EAEB,
                width: 0.7,)

              ),
            ),
            height: 40,
            width: 200,
            child: TextFormField(
              initialValue:item['firstRelease'] ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: clblack),
              ),
              decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
              onChanged: (value) {

              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),

            decoration: BoxDecoration(
              color: slNo=='Total'||slNo=='Grand Total'?clF2F2F2: clwhite ,
              border:Border(right: BorderSide( color: clE9EAEB,
                width:1,),left: BorderSide( color: clE9EAEB,
                width: 0.7,)

              ),
            ),
            height: 40,
            width: 200,
            child: TextFormField(
              initialValue:item['secondRelease'] ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: clblack),
              ),
              decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
              onChanged: (value) {

              },
            ),
          ),

        ],
      ),
    );
  }).toList();
}


Widget _buildEditableCell(BuildContext context,
    {required double width,
      required String value,
      required bool enabled,
      required Function(String) onChanged}) {
  return SizedBox(
    width: width,
    child: TextFormField(
      initialValue: value,
      enabled: enabled,
      textAlign: TextAlign.center,
      style: GoogleFonts.notoSans(
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: clblack),
      ),
      decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
      onChanged: onChanged,
    ),
  );
}