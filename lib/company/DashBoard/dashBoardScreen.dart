import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:provider/provider.dart';

import 'barchart.dart';

class DashBoardScreen extends StatelessWidget {
   DashBoardScreen({super.key});

  final List<Map<String, dynamic>> accounts = [
    {"title": "Cash in Hand", "amount": "zł150,000"},
    {"title": "PKO Bank", "amount": "zł100,000"},
    {"title": "ING Bank Śląski", "amount": "zł50,000"},
    {"title": "Bank Pekao", "amount": "zł80,000"},
    {"title": "Santander Bank", "amount": "zł60,000"},
    {"title": "mBank", "amount": "zł100,000"},
  ];

  @override
  Widget build(BuildContext context) {
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
  /*    appBar: PreferredSize(
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
                         *//* Container(
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
                              size: 24,
                              color: Colors.black, // optional
                            ),
                          ),
                          //  SizedBox(width: 12,),
*//*
                          // Title
                          Text(
                            'DashBoard',
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              color: Colors.black,
                            ),
                          ),

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
      ),*/


      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Expanded(
                  child: SummaryCard(
                    title: "Total Payables",
                    amount: "zł550,000",
                    color: Color(0xFFFFEBEB),
                    imagePath: 'asset/icons/payableScreen.png',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: SummaryCard(
                    title: "Total Receivables",
                    amount: "zł800,000",
                    color: Color(0xFFE7FBE8),
                   imagePath: 'asset/icons/totalReceivableIcon.png',

                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: accounts.map((acc) {
                return AccountCard(
                  title: acc["title"],
                  amount: acc["amount"],
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Consumer<MainProvider>(
              builder: (context, mainProvider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expenses: zł${NumberFormat('#,###').format(mainProvider.totalExpenses)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Show the calendar in a dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(50),
                              child: Dialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CalendarWidget(),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFFFAFAFA), // clFAFAFA as a hex color
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${mainProvider.selectedMonth}, ${mainProvider.selectedYear}',
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 8),
                            Image.asset(
                              'asset/icons/calenderIcon.png',
                              scale: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 30,),
            Container(
              color: clE5E5E5,
              height: 1,
              width: width,
            ),
            SizedBox(height: 12,),
            Expanded(
              child: SizedBox(
                  height: height/5,
                  child: ExpensesChart()),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final String imagePath;
  final Color? iconColor;

  const SummaryCard({
    required this.title,
    required this.amount,
    required this.color,
    required this.imagePath,
     this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 22),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, scale: 3,),
          const SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.notoSans(textStyle:TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500,color: cl808080) ) ),
              Text(amount,
                  style: GoogleFonts.notoSans(textStyle:TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700) ) ),
            ],
          ),
        ],
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  final String title;
  final String amount;

  const AccountCard({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 25),
      decoration: BoxDecoration(
        color: Color(0xFFF1F0FE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset('asset/icons/wallet-icon.png',scale: 3.5,),
          const SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              style: GoogleFonts.notoSans(textStyle:TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500,color: cl808080) ),

          ),

              const SizedBox(height: 4),
              Text(
                amount,
                  style: GoogleFonts.notoSans(textStyle:TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700) ) ,),
            ],
          ),
        ],
      ),
    );
  }
}




class CalendarWidget extends StatelessWidget {
  final List<String> months = [
    'Jan', 'Feb', 'Mar',
    'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep',
    'Oct', 'Nov', 'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return Container(
          height: 300,
          width: 250,
          child: Column(
            children: [
              // Year Picker
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_left),
                    onPressed: () {
                      mainProvider.setYear(mainProvider.selectedYear - 1);
                    },
                  ),
                  Text(
                    '${mainProvider.selectedYear}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right),
                    onPressed: () {
                      mainProvider.setYear(mainProvider.selectedYear + 1);
                    },
                  ),
                ],
              ),
              // Months Grid
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: months.length,
                  itemBuilder: (context, index) {
                    final month = months[index];
                    final isSelected = month == mainProvider.selectedMonth;
                    return GestureDetector(
                      onTap: () {
                        mainProvider.setMonth(month);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? cl8F1A3F : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            month,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}