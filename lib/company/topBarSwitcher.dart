import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/admin/sideBarForAmnin.dart';
import 'package:ledgifi/company/sideBar.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:provider/provider.dart';

import '../providers/mainProvider.dart';


class CompanySwitcherDemo extends StatefulWidget {
  const CompanySwitcherDemo({super.key});

  @override
  State<CompanySwitcherDemo> createState() => _CompanySwitcherDemoState();
}

class _CompanySwitcherDemoState extends State<CompanySwitcherDemo> {
  // int _selectedIndex = -1; // -1 represents admin view, 0 and above for companies

  final List<String> _companies = [
    'Company A',
    'Company B',
    'Company D',
    'Company E',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          // Top bar with company switcher
          Container(
            color: cl333333,
            child: Column(
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // Admin button
                      _buildAdminButton(),

                      // Company buttons
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              _companies.length,
                                  (index) => _buildCompanyButton(index),
                            ),
                          ),
                        ),
                      ),

                      // User profile button
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: [
                            Image.asset('asset/icons/userIcon.png',scale: 4,),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(
                                  'Tomasz Tomaszewski',
                                  style:GoogleFonts.notoSans(textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),)
                                ),
                                Text(
                                  'tomasz@gmail.com',
                                  style: GoogleFonts.notoSans(textStyle: TextStyle(
                                    color: clCCCCCC,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),)
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content area - loads different pages based on selection
          Expanded(
            child: _buildSelectedPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminButton() {
    final mainProvider = Provider.of<MainProvider>(context,listen: false);
    bool isSelected = mainProvider.topBarSelectedIndex == -1;

    return InkWell(
      onTap: () {
        setState(() {
          mainProvider.topBarSelectedIndex = -1; // Set to admin view
        });
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),

        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.white : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/icons/adminIcon.png',
              color: isSelected ? Colors.black : Colors.white,
              scale: 4,
            ),
            const SizedBox(width: 8),
            Text(
              'Admin',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyButton(int index) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    bool isSelected = mainProvider.topBarSelectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          mainProvider.topBarSelectedIndex = index;
          mainProvider.selectedIndex==0;
        });
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.white : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/icons/companyIcon.png',
              color: isSelected ? Colors.black : Colors.white,
              scale: 4,
            ),
            const SizedBox(width: 8),
            Text(
              _companies[index],
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to return the appropriate page based on selected index
  Widget _buildSelectedPage() {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    switch (mainProvider.topBarSelectedIndex) {
      case -1:
        print("printtttttttttttttttttttttttttttttt 1111111111");
        mainProvider.setSelectedIndex(0);// Admin view
        return SideBarScreenForAdmin();
      case 0:
        print("printtttttttttttttttttttttttttttttt 22222222222");
        mainProvider.setSelectedIndex(0);// Company A
        return SideBarScreenForCompany();
      case 1:
        print("printtttttttttttttttttttttttttttttt 33333333333");
        mainProvider.setSelectedIndex(0);// Company B
        return SideBarScreenForCompany();
      case 2:
        print("printtttttttttttttttttttttttttttttt 44444444444");
        mainProvider.setSelectedIndex(0);// Company D
        return SideBarScreenForCompany();
      case 3:
        print("printtttttttttttttttttttttttttttttt 555555555555");
        mainProvider.setSelectedIndex(0);// Company E
        return SideBarScreenForAdmin();
      default:
      // Default to admin if somehow we get an invalid index
        return SideBarScreenForAdmin();
    }
  }
}
