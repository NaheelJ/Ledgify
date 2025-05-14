import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/constants/myColors.dart';

class BalanceSheetScreen extends StatelessWidget {
  const BalanceSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Row(
              children: [

                Text(
                  'Balance Sheet',
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),

                // Search Field


                Expanded(child: const SizedBox(width: 16)),

                // Add Invoice Button
                Image.asset('asset/icons/pdfIcon.png',scale: 3.7,),

              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 600;
            return isWide
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: BalanceCard(title: "Assets", data: _assetsData)),
                SizedBox(width: 25),
                Expanded(child: BalanceCard(title: "Liabilities & Equities", data: _liabilitiesEquitiesData)),
              ],
            )
                : Column(
              children: const [
                BalanceCard(title: "Assets", data: _assetsData),
                SizedBox(height: 16),
                BalanceCard(title: "Liabilities & Equities", data: _liabilitiesEquitiesData),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final String title;
  final List<Map<String, String>> data;

  const BalanceCard({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    final isAssets = title == "Assets";

    return Container(
     // margin: const EdgeInsets.all(8.0),
      height:height/3 ,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: clD5D7DA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.notoSans(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          const Divider(),
        ...data.map((item) {
      if (item['label'] == 'divider') return const Divider();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item['label'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: (item['label'] == 'Liabilities' || item['label'] == 'Equities')
                      ? cl808080
                      : clblack,
                ),
              ),
            ),
            Text(
              item['value'] ?? '',
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    }),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isAssets ? "Total Assets" : "Total Liabilities & Equities",
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  "zł600,000",
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const List<Map<String, String>> _assetsData = [
  {"label": "Cash in Hand", "value": "zł150,000"},
  {"label": "PKO Bank", "value": "zł50,000"},
  {"label": "mBank", "value": "zł100,000"},
  {"label": "Bank Pekao", "value": "zł50,000"},
  {"label": "Vehicles", "value": "zł200,000"},
  {"label": "Office Supplies", "value": "zł50,000"},
];

const List<Map<String, String>> _liabilitiesEquitiesData = [
  {"label": "Liabilities", "value": ""},
  {"label": "Loans", "value": "zł100,000"},
  {"label": "Taxes", "value": "zł50,000"},
 // {"label": "divider", "value": ""},
  {"label": "Equities", "value": ""},
  {"label": "Capital", "value": "zł400,000"},
  {"label": "Reserve Fund", "value": "zł50,000"},
];
