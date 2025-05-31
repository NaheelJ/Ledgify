import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/constants/functions.dart';
import 'package:ledgifi/constants/myColors.dart';
import 'package:ledgifi/providers/loginProvider.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:ledgifi/widgets/custom_pagination.dart';
import 'package:provider/provider.dart';

class LedgersInFinantialOperationsScreen extends StatelessWidget {
  const LedgersInFinantialOperationsScreen({super.key});

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
            child: LayoutBuilder(
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
                              Text('Ledgers', style: GoogleFonts.notoSans(fontWeight: FontWeight.w600, fontSize: 19, color: Colors.black)),
                              const SizedBox(width: 18),
                              // Search Field
                              buildSearchTextField(mainProvider),
                            ],
                          ),

                          // Add Invoice Button
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 180,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  mainProvider.clearLedgerControllers();
                                  String newLedgerId = DateTime.now().millisecondsSinceEpoch.toString();
                                  mainProvider.setLedgerIsEditing(false, newLedgerId);
                                  showCreateLedgerDialog(context, mainProvider);
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
                                      Text("Create Ledger", style: GoogleFonts.notoSans(textStyle: TextStyle(color: clwhite, fontSize: 16, fontWeight: FontWeight.w500))),
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
              },
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
                          width: 1900,
                          child: Row(
                            children: [
                              SizedBox(width: 80, child: Text("Sl.No", style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clblack)))),
                              SizedBox(width: 400, child: Text("Ledger", style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clblack)))),
                              SizedBox(width: 250, child: Text("Opening Balance", style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clblack)))),
                              SizedBox(width: 380, child: Text("Group", style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clblack)))),
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
                        child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: _buildLedgersListRows(context))),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Pagination
            CustomPaginationButtons(
              currentPage: mainProvider.ledgerCurrentPageIndex + 1,
              totalPages: (mainProvider.ledgerDocCount / mainProvider.ledgerPageSize).ceil(),
              onPageSelected: (page) => mainProvider.fetchLedgersAtPage(page - 1),
              onPrevious: () {
                if (mainProvider.ledgerCurrentPageIndex > 0) {
                  mainProvider.fetchLedgersAtPage(mainProvider.ledgerCurrentPageIndex - 1);
                }
              },
              onNext: () {
                final nextPage = mainProvider.ledgerCurrentPageIndex + 1;
                final totalPages = (mainProvider.ledgerDocCount / mainProvider.ledgerPageSize).ceil();
                if (nextPage < totalPages) {
                  mainProvider.fetchLedgersAtPage(nextPage);
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
      width: 400, // Adjust width as needed
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: clFAFAFA, // Light background
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset('asset/icons/searchIcon.png', scale: 4),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: mainProvider.ledgersSearchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w400, fontSize: 16, color: cl666666),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onSubmitted: (value) => mainProvider.fetchInitialLedgers(),
              style: GoogleFonts.notoSans(fontWeight: FontWeight.w400, fontSize: 16, color: cl666666),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> _buildLedgersListRows(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  final MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

  if (mainProvider.isLoadingLedgersPagination) {
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

  if (mainProvider.ledgerList.isEmpty) {
    return [
      Center(
        child: Container(
          width: width,
          height: 40,
          alignment: Alignment.center,
          child: Text('No Ledgers Found', style: GoogleFonts.notoSans(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54))),
        ),
      ),
    ];
  }

  return mainProvider.ledgerList.asMap().entries.map((entry) {
    final index = entry.key;
    final item = entry.value;

    return Consumer<MainProvider>(
      builder:
          (context, person, child) => Container(
            width: 2200,
            height: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: index.isEven ? Colors.white : const Color(0xFFFAFAFA), border: const Border(bottom: BorderSide(color: Color(0xFFE9EAEB), width: 1))),
            child: Row(
              children: [
                SizedBox(width: 80, child: Text('${index + 1}', style: GoogleFonts.notoSans(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)))),
                SizedBox(width: 400, child: Text(item.name, style: GoogleFonts.notoSans(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)))),
                SizedBox(width: 250, child: Text('${item.openingBalance}', style: GoogleFonts.notoSans(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)))),

                // Bill Amount column (empty placeholder for now)
                SizedBox(width: 295, child: Text(item.groupName, style: GoogleFonts.notoSans(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)))),

                SizedBox(
                  width: 192,
                  child: InkWell(
                    onTap: () {
                      mainProvider.setLedgerIsEditing(true, item.ledgerId);
                      mainProvider.setLedgerControllers(name: item.name, openingBalance: item.openingBalance, groupName: item.groupName, groupId: item.groupId);
                      showCreateLedgerDialog(context, mainProvider);
                    },
                    child: Image.asset('asset/icons/editIcon.png', scale: 5),
                  ),
                ),
                SizedBox(
                  width: 169,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => DeleteLedgerDialog(
                              ledgerId: item.ledgerId,
                              onDelete: () {
                                mainProvider.deleteLedger(context, item.ledgerId);
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

class DeleteLedgerDialog extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onCancel;
  final String ledgerId;

  const DeleteLedgerDialog({Key? key, required this.onDelete, required this.onCancel, required this.ledgerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Consumer<MainProvider>(
      builder:
          (context, person, child) => Dialog(
            backgroundColor: clwhite,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child:
                person.isLoadingLedgerAdding
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
                                const Expanded(child: Text('Delete Ledger !', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                GestureDetector(onTap: onCancel, child: const Icon(Icons.close, size: 18)),
                              ],
                            ),
                            const SizedBox(height: 15),
                            const Text('Are you sure you want to delete ledger ?', style: TextStyle(fontSize: 16, color: Colors.black54)),
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

void showCreateLedgerDialog(BuildContext context, MainProvider mainProvider) {
  final LoginProvider loginProvider = Provider.of<LoginProvider>(context, listen: false);
  showDialog(
    context: context,
    barrierDismissible: true, // dismiss on tap outside
    builder: (context) {
      return Consumer<MainProvider>(
        builder:
            (context, person, child) => Dialog(
              backgroundColor: clwhite,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child:
                  person.isLoadingLedgerAdding
                      ? Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [CircularProgressIndicator(color: cl8F1A3F), const SizedBox(width: 24), Text('Loading..', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))],
                        ),
                      )
                      : SizedBox(
                        width: 580,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: StatefulBuilder(
                            builder:
                                (context, setState) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title and Close Button
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Create Ledger', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                        IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                                      ],
                                    ),
                                    const SizedBox(height: 16),

                                    // Ledger Name Field
                                    Consumer<MainProvider>(
                                      builder:
                                          (context, person, child) => customInputField(label: 'Ledger Name', controller: person.ledgerNameController, errorText: person.ledgerNameError.toString()),
                                    ),

                                    const SizedBox(height: 16),

                                    // Opening Balance Field
                                    Consumer<MainProvider>(
                                      builder:
                                          (context, person, child) => customInputField(
                                            label: 'Opening Balance',
                                            isNumber: true,
                                            controller: person.ledgerOpeningBalanceController,
                                            errorText: person.ledgerOpeningBalanceError.toString(),
                                          ),
                                    ),

                                    const SizedBox(height: 16),

                                    // Group Dropdown + Create Group Button
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(6)),
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    value: ['Rent', 'Sales', 'Utilities'].contains(mainProvider.selectedGroupName) ? mainProvider.selectedGroupName : null,
                                                    isExpanded: true,
                                                    dropdownColor: clwhite,
                                                    hint: const Text("Select Group"),
                                                    items: const [
                                                      DropdownMenuItem(value: 'Rent', child: Text('Rent')),
                                                      DropdownMenuItem(value: 'Sales', child: Text('Sales')),
                                                      DropdownMenuItem(value: 'Utilities', child: Text('Utilities')),
                                                    ],
                                                    onChanged: (value) {
                                                      if (value != null) {
                                                        mainProvider.setSelectedGroup(value, '11112222');
                                                      }
                                                    },
                                                    icon: const Icon(Icons.keyboard_arrow_down),
                                                  ),
                                                ),
                                              ),
                                              Consumer<MainProvider>(
                                                builder:
                                                    (context, value, child) =>
                                                        Text(mainProvider.selectedGroupError.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 20),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF4E8EC),
                                                border: Border.all(color: const Color(0xFF8F1A3F), width: 0.5),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.add, color: Color(0xFF8F1A3F), size: 20),
                                                  SizedBox(width: 6),
                                                  Text("Create Group", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF8F1A3F))),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
                                              back(context);
                                            },
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
                                        const SizedBox(width: 16),
                                        SizedBox(
                                          width: 150,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (mainProvider.isLoadingLedgerAdding) return;
                                              bool isValid = mainProvider.validateLedgerForm();

                                              if (!isValid) return;

                                              bool vendorAddingSuccess = await mainProvider.addLedger(
                                                context: context,
                                                addedById: loginProvider.usermodel!.userId,
                                                addedByName: loginProvider.usermodel!.name,
                                                companyId: '',
                                                companyName: '',
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: cl8F1A3F,
                                              foregroundColor: Colors.white,
                                              side: const BorderSide(color: Color(0xFFD5D7DA), width: 1),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                              elevation: 0,
                                            ),
                                            child: const Text("Save", style: TextStyle(color: clwhite, fontSize: 16, fontWeight: FontWeight.w500)),
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

Widget customInputField({required String label, bool isNumber = false, required TextEditingController controller, required String errorText}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(6)),
        child: TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            border: InputBorder.none,
            label: RichText(text: TextSpan(text: '$label ', style: const TextStyle(color: Colors.grey, fontSize: 16), children: const [TextSpan(text: '*', style: TextStyle(color: Colors.red))])),
          ),
        ),
      ),
      Text(errorText.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
    ],
  );
}
