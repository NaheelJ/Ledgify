import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ledgifi/company/employees%20management/employeesScreen.dart';
import 'package:ledgifi/constants/functions.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:provider/provider.dart';

import '../../company/employees management/addEmployeeScreen.dart';
import '../../company/topBarSwitcher.dart';
import 'addCompanyScreen.dart';

class DashBoardScreenAdmin  extends StatelessWidget {
  const DashBoardScreenAdmin({super.key});

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
              case "addCompany":
                return AddCompanyScreen();
              /*case "settlement":
                return InvoiceSettlementScreen();
              case "addVendor":
                return AddVentorScreen();*/
              case "dashBoard":
              default:
                return DashBoardScreenAdminHome();
            }
          },
        ),
      ),
    );
  }
}

class DashBoardScreenAdminHome extends StatelessWidget {
  DashBoardScreenAdminHome({super.key});

  final List<String> companies = [
    "Company A",
    "Company B",
    "Company C",
    "Company D",
    "Company E",
  ];


  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    // Define controllers outside of the build method but inside the class
    final TextEditingController controllerNew = TextEditingController();
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

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
                          'DashBoard',
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    // Right Section (Add Button)
                    SizedBox(
                      width: 180,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          mainProvider.clickAddButton('addCompany');

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
                                "Add Company",
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



      body: GridView.builder(
        shrinkWrap: true,
        itemCount: companies.length,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 340, // max width of each card
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3, // adjust based on your layout
        ),
        itemBuilder: (context, index) {
          return CompanyCard(
            title: companies[index],
            onClick: () {
              print("Clicked on ${companies[index]}");
             if( companies[index] == "Company A") {
               mainProvider.topBarSelectedIndex = 0;
                callNext(CompanySwitcherDemo(), context);
              } else if (companies[index] == "Company B") {
               mainProvider.topBarSelectedIndex = 1;
               callNext(CompanySwitcherDemo(), context);
                //mainProvider.clickAddButton('companyB');
              } else if (companies[index] == "Company C") {
               mainProvider.topBarSelectedIndex = 2;
               callNext(CompanySwitcherDemo(), context);
                //mainProvider.clickAddButton('companyC');
              } else if (companies[index] == "Company D") {
               mainProvider.topBarSelectedIndex = 3;
               callNext(CompanySwitcherDemo(), context);
                //mainProvider.clickAddButton('companyD');
              } else if (companies[index] == "Company E") {
               mainProvider.topBarSelectedIndex = 4;
               callNext(CompanySwitcherDemo(), context);
                //mainProvider.clickAddButton('companyE');
              }
            },
          );
        },
      ),
    );
  }

}


class CompanyCard extends StatelessWidget {
  final String title;
  final VoidCallback onClick;

  const CompanyCard({required this.title,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 25),
      decoration: BoxDecoration(
        color: clwhite,
        border: Border.all(color:clD5D7DA ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Row(
              children: [
                Image.asset('asset/icons/company1.png',scale: 3.5,),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.notoSans(textStyle:TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600,color: cl181D27) ),
                
                    ),
                
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: () {
                        showMoreDialogForFDashboard(context);
                      },
                      child: Text(
                        'View More Details',
                        style: GoogleFonts.notoSans(textStyle:TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: cl5856D6,
                            fontSize: 14, fontWeight: FontWeight.w400,color: cl5856D6) ) ,),
                    ),
                  ],
                ),
              ],
            ),
          ),

          InkWell(
               onTap: onClick,
              child: Image.asset('asset/icons/nextIcon.png',scale: 4,)),
        ],
      ),
    );
  }


  void showMoreDialogForFDashboard(BuildContext context) {
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
                            _buildInfoItem("Company Name", "Company A"),
                            SizedBox(height: 16,),
                            _buildInfoItem("Address", "789 Tech Street, Krakow, Poland"),
                            SizedBox(height: 16,),
                            _buildInfoItem("Contact Number", "987-654-21-09"),

                          ],
                        ),
                      ),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoItem("Email", "Companya@gmail.com"),
                            SizedBox(height: 16,),
                            _buildInfoItem("Contact Number", "+48 512345678"),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Delete Button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Handle delete
                          },
                          icon: Image.asset('asset/icons/deleteIcon.png',scale: 5.2,),
                          label: Text(
                            'Delete',
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: clF34745,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Edit Button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Handle edit
                          },
                          icon: Image.asset('asset/icons/editIcon.png',scale: 5.2,),
                          label: Text(
                            'Edit',
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: cl007AFF,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                          ),
                        ),
                      ),
                    ],
                  )


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




}