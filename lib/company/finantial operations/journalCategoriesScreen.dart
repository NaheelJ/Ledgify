import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:provider/provider.dart';
class JournalCategoriesScreen extends StatelessWidget {
  const JournalCategoriesScreen({super.key});

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
            child:LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: constraints.maxWidth),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
                              children: [
                                Text(
                                  'Journal Categories',
                                  style: GoogleFonts.notoSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 18),
                                // Search Field
                                buildSearchTextField(),
                              ],
                            ),



                            // Add Invoice Button
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 260,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showCreateLedgerDialog(context);
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
                                            "Create Journal Category",
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
                }
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
                      width: 1900,
                      height: height/1.17,
                      decoration: BoxDecoration(
                        border: Border.all(color: clE9EAEB), // Outer border
                        borderRadius: BorderRadius.circular(10), ),

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
                                  width: 1900, // Sum of all column widths
                                  height: 44,
                                  padding: const EdgeInsets.symmetric(horizontal: 10,),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(bottom: BorderSide(
                                      color: Color(0xFFE9EAEB),
                                      width: 1,
                                    ),) ,
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
                                        width: 545,
                                        child: Text(
                                            "Journal Category",
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
                                            "Edit",
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
                                            "Delete",
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
                                  children: _buildJournalCategoryListRows(context),
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
      width: 500, // Adjust width as needed
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
List<Widget> _buildJournalCategoryListRows(BuildContext context) {
  var width = MediaQuery.of(context).size.width;

  // Dummy data
  final List<Map<String, String>> dummyList = [
    {
      'slNo': '1',
      'journalCategory': 'Snacks & Refreshments',

    },
    {
      'slNo': '2',
      'journalCategory': 'Stationery',

    },
    {
      'slNo': '3',
      'journalCategory': 'Snacks & Refreshments',


    },
    {
      'slNo': '4',
      'journalCategory': 'Meals / Lunch',

    },
    {
      'slNo': '5',
      'journalCategory': 'Printing & Postage',


    },
    {
      'slNo': '6',
      'journalCategory': 'Mertz Travel Poland',


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
        color: index.isEven ? Colors.white : const Color(0xFFFAFAFA),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFE9EAEB),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              item['slNo'] ?? '',
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
            width: 460,
            child: Text(
              item['journalCategory'] ?? '',
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
            width: 192,
            child: InkWell(
              onTap: () {

              },
              child:Image.asset(
                'asset/icons/editIcon.png',
                scale: 5,
              ),
            ),
          ),
          SizedBox(
            width: 169,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => DeleteVendorDialog(
                    onDelete: () {
                      // Delete logic
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              child:Image.asset(
                'asset/icons/deleteIcon.png',
                scale: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();
}




class DeleteVendorDialog extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  const DeleteVendorDialog({
    Key? key,
    required this.onDelete,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: clwhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: 180,
        width: 360,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Delete Category!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onCancel,
                    child: const Icon(Icons.close, size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                'Are you sure you want to delete Category ?',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Save action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: clF34745,
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFFD5D7DA), width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Delete",
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
  }
}


void showCreateLedgerDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // dismiss on tap outside
    builder: (context) {
      String? selectedGroup;

      return Dialog(
        backgroundColor: clwhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          height: 250,
          width: 580,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: StatefulBuilder(
              builder: (context, setState) => SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Close Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Create Journal Category',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Ledger Name Field
                    Consumer<MainProvider>(
                      builder: (context,mainProvider,child) {
                        return Container(
                          // Optional: reduce outer padding if not needed
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: mainProvider.borderColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextField(
                            focusNode: mainProvider.createJournalNode,
                            style:GoogleFonts.notoSans(textStyle:  TextStyle(color: clblack)),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              isDense: true, // Reduces vertical spacing
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust as needed
                              border: InputBorder.none,
                              label: RichText(
                                text: TextSpan(
                                  text: 'Category Name ',
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
                        );
                      }
                    ),



                    const SizedBox(height: 24),

                    // Cancel and Save Buttons
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
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
Widget customInputField({required String label, bool isNumber = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(6),
    ),
    child: TextField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        border: InputBorder.none,
        label: RichText(
          text: TextSpan(
            text: '$label ',
            style: const TextStyle(color: Colors.grey, fontSize: 16),
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}





