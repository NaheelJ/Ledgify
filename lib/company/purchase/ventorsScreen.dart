import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ledgifi/company/purchase/ventors/addVentorScreen.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:ledgifi/widgets/custom_pagination.dart';
import 'package:provider/provider.dart';

class VendorsInPurchaseScreen extends StatelessWidget {
  const VendorsInPurchaseScreen({super.key});

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
              case "vendor_addVendor":
                return AddVentorScreen();
              case "vendor_vendorScreen":
              default:
                return VendorsInPurchaseScreenHome();
            }
          },
        ),
      ),
    );
  }
}

class VendorsInPurchaseScreenHome extends StatelessWidget {
  const VendorsInPurchaseScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: clwhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(125),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD5D7DA)), borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Row(
              children: [
                Text('Vendors', style: GoogleFonts.notoSans(fontWeight: FontWeight.w600, fontSize: 19, color: Colors.black)),
                const SizedBox(width: 18),
                // Search Field
                buildSearchTextField(mainProvider),

                Expanded(child: const SizedBox(width: 16)),

                // Add Invoice Button
                SizedBox(
                  width: 180,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      // Save action
                      String vendorId = DateTime.now().millisecondsSinceEpoch.toString();
                      mainProvider.setVendorIsEditing(false, vendorId);
                      mainProvider.clearVendorControllers();
                      Provider.of<MainProvider>(context, listen: false).clickAddButton('vendor_addVendor');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cl8F1A3F,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFD5D7DA), width: 1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("+ ", style: GoogleFonts.notoSans(textStyle: TextStyle(color: clwhite, fontSize: 22, fontWeight: FontWeight.w800))),
                          Text("Add Vendors", style: GoogleFonts.notoSans(textStyle: TextStyle(color: clwhite, fontSize: 16, fontWeight: FontWeight.w500))),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            // Table content
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: clE9EAEB), // Outer border
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    // Fixed Header
                    Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: Color(0xFFE9EAEB), width: 1)),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: 1900, // Sum of all column widths
                          child: Row(
                            children: [
                              SizedBox(width: 80, child: Text("Sl.No", style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clblack)))),
                              SizedBox(width: 400, child: Text("Vendor Name", style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clblack)))),
                              SizedBox(width: 250, child: Text("Contact Number", style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clblack)))),
                              SizedBox(width: 380, child: Text("Email", style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clblack)))),
                              SizedBox(width: 200, child: Text("Invoices", style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clblack)))),
                              SizedBox(width: 200, child: Text("View More", style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clblack)))),
                              SizedBox(width: 180, child: Text("Edit", style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clblack)))),
                              SizedBox(width: 180, child: Text("Delete", style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clblack)))),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Scrollable Table Body
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: _buildVendorListRows(context))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomPaginationButtons(
              currentPage: mainProvider.vendorCurrentPageIndex + 1,
              totalPages: (mainProvider.vendorDocCount / mainProvider.vendorPageSize).ceil(),
              onPageSelected: (page) => mainProvider.fetchVendorsAtPage(page - 1),
              onPrevious: () {
                if (mainProvider.vendorCurrentPageIndex > 0) {
                  mainProvider.fetchVendorsAtPage(mainProvider.vendorCurrentPageIndex - 1);
                }
              },
              onNext: () {
                final nextPage = mainProvider.vendorCurrentPageIndex + 1;
                final totalPages = (mainProvider.vendorDocCount / mainProvider.vendorPageSize).ceil();
                if (nextPage < totalPages) {
                  mainProvider.fetchVendorsAtPage(nextPage);
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildSearchTextField(MainProvider mainProvider) {
    return Container(
      height: 45,
      width: 320, // Adjust width as needed
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: clwhite, // Light background
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset('asset/icons/searchIcon.png', scale: 4),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: mainProvider.vendorsSearchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w400, fontSize: 14, color: cl666666),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onSubmitted: (value) => mainProvider.fetchInitialVendors(),
              style: GoogleFonts.notoSans(fontWeight: FontWeight.w400, fontSize: 14, color: cl666666),
            ),
          ),
        ],
      ),
    );
  }

  // dropdown
  Widget _buildDropdown(BuildContext context, {required String value, required List<String> items, required ValueChanged<String?> onChanged}) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(color: clFAFAFA, border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: clwhite,
          value: value,
          icon: Image.asset('asset/icons/arrowDown.png', scale: 4),
          style: GoogleFonts.notoSans(fontWeight: FontWeight.w400, fontSize: 14, color: cl666666),
          onChanged: onChanged,
          items:
              items.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildDateBox({required BuildContext context, required String imagePath, required String hint, required DateTime? selectedDate, required Function(DateTime) onDateSelected}) {
    return GestureDetector(
      onTap: () async {
        DateTime initialDate = selectedDate ?? DateTime.now();
        DateTime? picked = await showDatePicker(context: context, initialDate: initialDate, firstDate: DateTime(2000), lastDate: DateTime(2100));
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(color: clFAFAFA, border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null ? '${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}' : hint,
              style: GoogleFonts.notoSans(fontWeight: FontWeight.w400, fontSize: 14, color: cl666666),
            ),
            const SizedBox(width: 6),
            Image.asset(imagePath, scale: 3.5),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(String label, bool isFromDate) {
    return Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: clwhite));
  }
}

List<Widget> _buildVendorListRows(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  final MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

  if (mainProvider.isLoadingVendorsPagination) {
    // Loading state
    return [
      Center(
        child: SizedBox(
          width: 1900,
          height: 120,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: cl8F1A3F),
                const SizedBox(height: 12),
                Text('Loading...', style: GoogleFonts.notoSans(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black))),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  if (mainProvider.vendorList.isEmpty) {
    return [
      Center(
        child: Container(
          width: width,
          height: 40,
          alignment: Alignment.center,
          child: Text('No Vendors Found', style: GoogleFonts.notoSans(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54))),
        ),
      ),
    ];
  }

  return mainProvider.vendorList.asMap().entries.map((entry) {
    final index = entry.key;
    final item = entry.value;

    return Consumer<MainProvider>(
      builder:
          (context, value, child) => Container(
            width: 2200,
            height: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: index.isEven ? Colors.white : const Color(0xFFFAFAFA), border: const Border(bottom: BorderSide(color: Color(0xFFE9EAEB), width: 1))),
            child: Row(
              children: [
                SizedBox(width: 80, child: Text('${index + 1}', style: GoogleFonts.notoSans(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black)))),
                SizedBox(width: 400, child: Text(item.name, style: GoogleFonts.notoSans(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black)))),
                SizedBox(width: 250, child: Text(item.phone, style: GoogleFonts.notoSans(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black)))),

                // Bill Amount column (empty placeholder for now)
                SizedBox(width: 380, child: Text(item.email, style: GoogleFonts.notoSans(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black)))),
                SizedBox(
                  width: 200,
                  child: InkWell(
                    onTap: () {
                      // Navigate to invoices screen
                    },
                    child: Text(
                      'Invoices',
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: cl5856D6, decoration: TextDecoration.underline, decorationColor: cl5856D6),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: InkWell(
                    onTap: () {
                      showMoreDialog(context, vendorName: item.name, email: item.email, vendorId: item.vendorId, contactNumber: item.phone, address: item.address, addedDate: item.addedOn!);
                    },
                    child: Text(
                      'View More',
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: cl5856D6, decoration: TextDecoration.underline, decorationColor: cl5856D6),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 230,
                  child: InkWell(
                    onTap: () {
                      mainProvider.setVendorControllers(
                        name: item.name,
                        email: item.email,
                        address: item.address,
                        phone: item.phone,
                        contactPerson: item.contactPerson,
                        openingBalance: item.openingBalance,
                        balanceAmount: item.balanceAmount,
                      );

                      mainProvider.setVendorIsEditing(true, item.vendorId);
                      Provider.of<MainProvider>(context, listen: false).clickAddButton('vendor_addVendor');
                    },
                    child: Image.asset('asset/icons/editIcon.png', scale: 5),
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => DeleteVendorDialog(
                              onDelete: () {
                                // Delete logic
                                mainProvider.deleteVendor(context, item.vendorId);
                              },
                              onCancel: () {
                                Navigator.pop(context);
                              },
                            ),
                      );
                    },
                    child: Image.asset('asset/icons/deleteIcon.png', scale: 4),
                  ),
                ),
              ],
            ),
          ),
    );
  }).toList();
}

// Reusable text cell builder
Widget _buildCell(String? text, double width) {
  return SizedBox(width: width, child: Text(text ?? '', style: GoogleFonts.notoSans(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: clblack))));
}

class DeleteVendorDialog extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  const DeleteVendorDialog({Key? key, required this.onDelete, required this.onCancel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder:
          (context, person, child) => Dialog(
            backgroundColor: clwhite,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child:
                person.isLoadingVendorAdding
                    ? Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [CircularProgressIndicator(color: cl8F1A3F), const SizedBox(width: 24), Text('Loading..', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))],
                      ),
                    )
                    : SizedBox(
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
                                const Expanded(child: Text('Delete Vendor !', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                GestureDetector(onTap: onCancel, child: const Icon(Icons.close, size: 18)),
                              ],
                            ),
                            const SizedBox(height: 15),
                            const Text('Are you sure you want to delete vendor ?', style: TextStyle(fontSize: 14, color: Colors.black54)),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: 150,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: onCancel,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        side: const BorderSide(color: Color(0xFFD5D7DA), width: 1),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                        elevation: 0,
                                      ),
                                      child: const Text("Cancel", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: SizedBox(
                                    width: 150,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: onDelete,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: clF34745,
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(color: Color(0xFFD5D7DA), width: 1),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                        elevation: 0,
                                      ),
                                      child: const Text("Delete", style: TextStyle(color: clwhite, fontSize: 16, fontWeight: FontWeight.w500)),
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
    );
  }
}

// Reusable text cell builder

void showMoreDialog(
  BuildContext context, {
  required String vendorName,
  required String email,
  required String vendorId,
  required String contactNumber,
  required String address,
  required DateTime addedDate,
}) {
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
                    Text("More Details", style: GoogleFonts.notoSans(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                    IconButton(icon: const Icon(Icons.close, size: 20), onPressed: () => Navigator.of(context).pop()),
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
                        children: [_buildInfoItem("Vendor Name", vendorName), SizedBox(height: 16), _buildInfoItem("Email", email), SizedBox(height: 16), _buildInfoItem("Vendor ID", vendorId)],
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoItem("Contact Number", contactNumber),
                          SizedBox(height: 16),
                          _buildInfoItem("Address", address),
                          SizedBox(height: 16),
                          _buildInfoItem("Added Date Time", DateFormat('dd-MM-yyyy HH:mm').format(addedDate)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
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
        Text(title, style: GoogleFonts.notoSans(fontWeight: FontWeight.w400, fontSize: 12, color: cl808080)),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.notoSans(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black)),
      ],
    ),
  );
}
