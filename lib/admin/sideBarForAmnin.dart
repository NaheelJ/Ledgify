
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/admin/dashBoard/dashBoardAdmin.dart';
import 'package:ledgifi/admin/users/usersScreen.dart';
import 'package:ledgifi/company/DashBoard/dashBoardScreen.dart';
import 'package:ledgifi/company/finantial%20operations/GroupScreen.dart';
import 'package:ledgifi/company/finantial%20operations/journalCategoriesScreen.dart';
import 'package:ledgifi/company/finantial%20operations/ledgersInFinantialOperationsScreen.dart';
import 'package:ledgifi/company/loginScreen.dart';
import 'package:ledgifi/company/purchase/purchaseRecordScreen.dart';
import 'package:ledgifi/company/purchase/ventorsScreen.dart';

import 'package:ledgifi/company/reports/balanceSheet.dart';
import 'package:ledgifi/company/reports/dayBookScreen.dart';
import 'package:ledgifi/company/reports/ledgersScreenInReports.dart';
import 'package:ledgifi/company/sales/customersScreen.dart';
import 'package:ledgifi/company/sales/salesRecordScreen.dart';

import 'package:ledgifi/constants/myColors.dart';
import 'package:provider/provider.dart';

import '../providers/mainProvider.dart';
class SideBarScreenForAdmin extends StatelessWidget {
  SideBarScreenForAdmin({super.key});

  final List<Widget> sections = [
    DashBoardScreenAdmin(),
    PurchaseRecordScreen(),
    VendorsInPurchaseScreen(),
    SalesRecordScreen(),
    CustomersInSalesScreen(),
    DayBookScreenInReport(),
    UsersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          const SidebarForCompany(),
          Expanded(
            child: sections[
            provider.selectedIndex >= 0 && provider.selectedIndex < sections.length
                ? provider.selectedIndex
                : 0],
          ),
        ],
      ),
    );
  }
}

class SidebarForCompany extends StatelessWidget {
  const SidebarForCompany({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width / 6,

      decoration: BoxDecoration(
          color: Colors.white,
        border:Border(right: BorderSide(color: clD5D7DA))
      ),
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Top Logo Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('asset/icons/logo2.png', scale: 2.5),
                Image.asset('asset/icons/menuIcon.png', scale: 3),
              ],
            ),

            const SizedBox(height: 22),

            // Static Items
            SidebarItem(
              label: 'Companies',
              selected: provider.selectedIndex == 0,
              onTap: () => provider.setSelectedIndex(0),
              imagePath: 'asset/icons/companyIcon.png',
            ),

            // Expandable Report Items
            SidebarExpandable(
              label: 'Reports',
              imagePath: 'asset/icons/reportsIcon.png',
              subItems: [
                SidebarSubItem(
                    label: 'Purchase Report',
                    index: 1,
                    imagePath: 'asset/icons/purchaseReportAd.png'),
                SidebarSubItem(
                    label: 'Sales Report ',
                    index: 2,
                    imagePath: 'asset/icons/salesReportAd.png'),
                SidebarSubItem(
                    label: 'Expenses Report ',
                    index: 3,
                    imagePath: 'asset/icons/expenseReportAd.png'),
                SidebarSubItem(
                    label: 'Salary Report',
                    index: 4,
                    imagePath: 'asset/icons/salaryReport.png'),
              ],
            ),

            // Users
            SidebarItem(
              label: 'Users',
              imagePath: 'asset/icons/usersIcon.png',
              selected: provider.selectedIndex == 6,
              onTap: () => provider.setSelectedIndex(6),
            ),

           /* const Spacer(),

            // Bottom Company Info
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: const Border(top: BorderSide(color: Colors.grey)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF0F0F0),
                      ),
                      child: const Center(
                        child: Icon(Icons.apartment, size: 20, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Company A',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'companya@gmail.com',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

// Sidebar Item Widget
class SidebarItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String imagePath;

  const SidebarItem({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ?  cl8F1A3F : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: imagePath != null
            ? Image.asset(imagePath, color: selected ? Colors.white : Colors.black,scale: 4,)
            : null,
        title: Text(
          label,
          style: GoogleFonts.notoSans(
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

// Sidebar with SubItems
class SidebarExpandable extends StatefulWidget {
  final String label;
  final String imagePath;
  final List<SidebarSubItem> subItems;

  const SidebarExpandable({
    super.key,
    required this.label,
    required this.imagePath,
    required this.subItems,
  });

  @override
  State<SidebarExpandable> createState() => _SidebarExpandableState();
}

class _SidebarExpandableState extends State<SidebarExpandable> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _isExpanded ? const Color(0xFFF4E8EC) : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          collapsedIconColor: Colors.black,
          iconColor: Colors.black,
          leading: Image.asset(widget.imagePath, color: Colors.black,scale: 4,),
          title: Text(
            widget.label,
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.w500,
              fontSize: 14.5,
              color: Colors.black,
            ),
          ),
          children: widget.subItems.map((sub) {
            bool isSelected = provider.selectedIndex == sub.index;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF8F1A3F) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: ListTile(
                leading: Image.asset(
                  sub.imagePath,
                  scale: 4,
                  color: isSelected ? Colors.white : Colors.black,
                ),
                title: Text(
                  sub.label,
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.5,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                onTap: () => provider.setSelectedIndex(sub.index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Sub Item Model
class SidebarSubItem {
  final String label;
  final int index;
  final String imagePath;

  SidebarSubItem({
    required this.label,
    required this.index,
    required this.imagePath,
  });
}
