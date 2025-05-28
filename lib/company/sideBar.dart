
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'employees management/employeesScreen.dart';
import 'employees management/payRollScreen.dart';
import 'journal entry/internal transfer/internalTransferScreen.dart';
import 'journal entry/paymentPortalScreen.dart';
import 'journal entry/receiptPortalScreen.dart';
class SideBarScreenForCompany extends StatelessWidget {
  SideBarScreenForCompany({super.key});

  final List<Widget> sections =  [
    DashBoardScreen(),
    PurchaseRecordScreen(),
    VendorsInPurchaseScreen(),
    SalesRecordScreen(),
    CustomersInSalesScreen(),
    PaymentPortalScreen(),
    ReceiptPortalScreen(),
    InternalTransferScreen(),
    DayBookScreenInReport(),
    LedgerScreenInReports(),
    BalanceSheetScreen(),
    LedgersInFinantialOperationsScreen(),
    GroupScreen(),
    // JournalCategoriesScreen(),
    EmployeesScreen(),
    PayRollScreen()
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
            child: sections[provider.selectedIndex < 0 ? 0 : provider.selectedIndex],
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
        border: Border(right: BorderSide(color: clD5D7DA,width: 1))
      ),
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('asset/icons/logo2.png', scale: 2.5),
                Image.asset('asset/icons/menuIcon.png', scale: 3),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  SidebarItem(
                    label: 'Dashboard',
                    selected: provider.selectedIndex == 0,
                    onTap: () => provider.setSelectedIndex(0),
                    imagePath: 'asset/icons/dashBoardIcon.png',
                  ),
                  SidebarExpandable(
                    label: 'Purchase',
                    imagePath: 'asset/icons/purchaseIcon.png',
                    subItems: [
                      SidebarSubItem(label: 'Purchase Records', index: 1, imagePath: 'asset/icons/purchaseRecordIcon.png'),
                      SidebarSubItem(label: 'Vendors', index: 2, imagePath: 'asset/icons/vendor.png'),
                    ],
                  ),
                  SidebarExpandable(
                    label: 'Sales',
                    imagePath: 'asset/icons/salesicon.png',
                    subItems: [
                      SidebarSubItem(label: 'Sales Records', index: 3, imagePath: 'asset/icons/salesRecordIcon.png'),
                      SidebarSubItem(label: 'Customers', index: 4, imagePath: 'asset/icons/customesIcon.png'),
                    ],
                  ),
                  SidebarExpandable(
                    label: 'Journal Entry',
                    imagePath: 'asset/icons/journalEntryIcon.png',
                    subItems: [
                      SidebarSubItem(label: 'Payment Portal', index: 5, imagePath: 'asset/icons/paymentPortalicon.png'),
                      SidebarSubItem(label: 'Receipt Portal', index: 6, imagePath: 'asset/icons/receiptPortalIcon.png'),
                      SidebarSubItem(label: 'Internal Transfer', index: 7, imagePath: 'asset/icons/internalTransferIcon.png'),
                    ],
                  ),
                  SidebarExpandable(
                    label: 'Reports',
                    imagePath: 'asset/icons/reportsIcon.png',
                    subItems: [
                      SidebarSubItem(label: 'Daybook', index: 8, imagePath: 'asset/icons/dayBookIcon.png'),
                      SidebarSubItem(label: 'Ledgers', index: 9, imagePath: 'asset/icons/ledgersIcon.png'),
                      SidebarSubItem(label: 'Balance Sheet', index: 10, imagePath: 'asset/icons/balanceSheetIcon.png'),
                    ],
                  ),
                  SidebarExpandable(
                    label: 'Financial Operations',
                    imagePath: 'asset/icons/finantial.png',
                    subItems: [
                      SidebarSubItem(label: 'Ledgers', index: 11, imagePath: 'asset/icons/ledgersIcon.png'),
                      SidebarSubItem(label: 'Groups', index: 12, imagePath: 'asset/icons/groupsIcon.png'),
                    ],
                  ),
                  SidebarExpandable(
                    label: 'Staff Management',
                    imagePath: 'asset/icons/staffManagementicon.png',
                    subItems: [
                      SidebarSubItem(label: 'Staffs', index: 13, imagePath: 'asset/icons/staffsicon.png'),
                      SidebarSubItem(label: 'Payroll', index: 14, imagePath: 'asset/icons/payRollIcon.png'),
                    ],
                  ),
                ],
              ),
            ),
           /* const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
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
                      child: Icon(
                        Icons.apartment,
                        size: 20,
                        color: Colors.black54,
                      ),
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
            ),*/
          ],
        ),
      ),
    );
  }
}

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
        color: selected ? const Color(0xFF8F1A3F) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListTile(
        leading: Image.asset(imagePath, color: selected ? Colors.white : Colors.black, scale: 4),
        title: Text(
          label,
          style: GoogleFonts.notoSans(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

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
       /* border: Border(
          bottom: BorderSide(
            color: provider.selectedIndex == 1 ? clCCCCCC : Colors.transparent,
          ),
        ),*/
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (expanded) {
            setState(() => _isExpanded = expanded);
          },
          collapsedIconColor: Colors.black,
          iconColor: Colors.black,
          leading: Image.asset(widget.imagePath, color: Colors.black, scale: 4),
          title: Text(
            widget.label,
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          children: widget.subItems.map((sub) {
            final isSelected = provider.selectedIndex == sub.index;
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
                    fontSize: 14,
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

class SidebarSubItem {
  final String label;
  final int index;
  final String imagePath;

  const SidebarSubItem({
    required this.label,
    required this.index,
    required this.imagePath,
  });
}