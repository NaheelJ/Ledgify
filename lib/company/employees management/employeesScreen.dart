import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/company/employees%20management/addEmployeeScreen.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:provider/provider.dart';

import '../../providers/mainProvider.dart';
class EmployeesScreen  extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: clwhite,
        body: Consumer<MainProvider>(
          builder: (ctx, adminRetailerPro, _) {
            String id = DateTime.now().millisecondsSinceEpoch.toString();
            switch (adminRetailerPro.changeScreenWidgets.value) {
              case "employeeManagement_addEmployee":
                return AddEmployeeScreen();
              case "employeeManagement_default":
              default:
                return EmployeesScreenHome();
            }
          },
        ),
      ),
    );
  }
}
class EmployeesScreenHome extends StatelessWidget {
  const EmployeesScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Define controllers outside of the build method but inside the class
    final TextEditingController controllerNew = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: clwhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
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
                return Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Left Section (Title + Search)
                    Wrap(
                      spacing: 16,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'Employees',
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: Colors.black,
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth < 500 ? constraints.maxWidth * 0.9 : 300,
                          ),
                          child: buildSearchTextField(),
                        ),
                      ],
                    ),

                    // Right Section (Add Button)
                    SizedBox(
                      width: 180,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<MainProvider>(context, listen: false).clickAddButton('employeeManagement_addEmployee');

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
                        child: FittedBox(
                          child: Row(
                            children: [
                              Text(
                                "+ ",
                                style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                    color: clwhite,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Text(
                                "Add Employee",
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
                    ),
                  ],
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
                      width: 1900,
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
                                          width: 400,
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
                                          width: 400,
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
                                          width: 210,
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
                                          width: 210,
                                          child: Text(
                                              "Contact Number",
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
                                              "View More",
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
                                    children: _buildEmployeeListRows(context),
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
      width: 320, // Adjust width as needed
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
                fillColor: clF2F2F2,
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
                                      fontWeight:i == 3 ? FontWeight.w400 : FontWeight.w400,
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
List<Widget> _buildEmployeeListRows(BuildContext context) {
  var width = MediaQuery.of(context).size.width;

  // Dummy data
  final List<Map<String, String>> dummyList = [
    {
      'Name': 'Kacper',
      'surname': 'Kacprzak',
      'employeeId': 'XY98765',
      'contactNumber': '+48 512345678',
    },
    {
      'Name': 'Marek',
      'surname': 'Maretkowski',
      'employeeId': 'AB54321',
      'contactNumber': '+48 648345678',
    },
    {
      'Name': 'Tomasz',
      'surname': 'Tomaszewski',
      'employeeId': 'CD67890',
      'contactNumber': '+48 785345678',
    },
    {
      'Name': 'Jakub',
      'surname': 'Jakubowicz',
      'employeeId': 'EF13579',
      'contactNumber': '+48 586345678',
    },
    {
      'Name': 'Szymon',
      'surname': 'Szymonowicz',
      'employeeId': 'GH24680',
      'contactNumber': '+48 536345678',
    },
    {
      'Name': 'Filip',
      'surname': 'Filipowski',
      'employeeId': 'IJ35791',
      'contactNumber': '+48 512345678',
    },
    {
      'Name': 'Wojciech',
      'surname': 'Wojciechowski',
      'employeeId': 'KL46802',
      'contactNumber': '+48 658345678',
    },
    {
      'Name': 'Olek',
      'surname': 'Olekowski',
      'employeeId': 'MN57913',
      'contactNumber': '+48 512345678',
    },
    {
      'Name': 'Mikołaj',
      'surname': 'Mikołajczyk',
      'employeeId': 'OP68024',
      'contactNumber': '+48 789345678',
    },
    {
      'Name': 'Dominik',
      'surname': 'Dominikowicz',
      'employeeId': 'QR79135',
      'contactNumber': '+48 512345678',
    },
    {
      'Name': 'Patryk',
      'surname': 'Patrykowski',
      'employeeId': 'ST80246',
      'contactNumber': '+48 789345678',
    },
    {
      'Name': 'Bartosz',
      'surname': 'Bartoszewski',
      'employeeId': 'UV91357',
      'contactNumber': '+48 512345678',
    },
  ];

  return dummyList.asMap().entries.map((entry) {
    final index = entry.key;
    final item = entry.value;

    return Container(
      width: 2200,
      height: 41,
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
              '${index + 1}', // Automatically generate Sl.No
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
            width: 400,
            child: Text(
              item['Name'] ?? '',
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
            width: 400,
            child: Text(
              item['surname'] ?? '',
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
            width: 210,
            child: Text(
              item['employeeId'] ?? '',
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
            width: 210,
            child: Text(
              item['contactNumber'] ?? '',
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
            width: 100,
            child: InkWell(
              onTap: () {
                showMoreDialog(context);
              },
              child: Text(
                'View More',
                style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: cl5856D6,
                    decoration: TextDecoration.underline,
                    decorationColor: cl5856D6,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 230,
            child: InkWell(
              onTap: () {
                // Edit logic
              },
              child: Image.asset(
                'asset/icons/editIcon.png',
                scale: 3.5,
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => DeleteEmployeeDialog(
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
              child: Image.asset(
                'asset/icons/deleteIcon.png',
                scale: 3.5,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// Reusable text cell builder

void showMoreDialog(BuildContext context) {
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
                      "More Details",
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
                          _buildInfoItem("Name", "Kacper"),
                          SizedBox(height: 16,),
                          _buildInfoItem("Employee ID", "XY98765"),
                          SizedBox(height: 16,),
                          _buildInfoItem("Contact Number", "+48 512345678"),
                          SizedBox(height: 16,),
                          _buildInfoItem("Passport Number ", "XR8825489"),

                        ],
                      ),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoItem("Surname", "Kacprzak"),
                          SizedBox(height: 16,),
                          _buildInfoItem("Role", "Training Coordinator"),
                          SizedBox(height: 16,),
                          _buildInfoItem("Email", "john.doe@techhub.com"),
                          SizedBox(height: 16,),
                          _buildInfoItem("Pesel Number", "87546231000"),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16,),

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



class DeleteEmployeeDialog extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  const DeleteEmployeeDialog({
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
                      'Delete Staff',
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
                'Are you sure you want to delete Employee ?',
                style: TextStyle(fontSize: 16, color: cl382E2E,fontWeight: FontWeight.w400),
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