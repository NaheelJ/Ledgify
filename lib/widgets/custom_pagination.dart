import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/constants/myColors.dart';

class CustomPaginationButtons extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final void Function(int page) onPageSelected;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const CustomPaginationButtons({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
    required this.onPrevious,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalVisiblePages = 6;

    int startPage = currentPage - (totalVisiblePages ~/ 2);
    int endPage = currentPage + (totalVisiblePages ~/ 2) - 1;

    if (startPage < 1) {
      endPage += (1 - startPage);
      startPage = 1;
    }
    if (endPage > totalPages) {
      startPage -= (endPage - totalPages);
      endPage = totalPages;
      if (startPage < 1) startPage = 1;
    }

    List<Widget> paginationButtons = [];
    for (int i = startPage; i <= endPage && i <= totalPages; i++) {
      final isSelected = currentPage == i;
      paginationButtons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: TextButton(
            onPressed: () => onPageSelected(i),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: isSelected ? Colors.grey : clwhite),
              ),
              minimumSize: const Size(40, 40),
            ),
            child: Text(
              '$i',
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Total : $totalPages',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: cl666666,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Previous
                    GestureDetector(
                      onTap: currentPage > 1 ? onPrevious : null,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: currentPage > 1 ? Colors.grey.shade300 : Colors.grey.shade200,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: currentPage > 1 ? Colors.grey.shade700 : Colors.grey.shade400,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),

                    // Page buttons
                    ...paginationButtons,

                    SizedBox(width: 8),

                    // Next
                    GestureDetector(
                      onTap: currentPage < totalPages ? onNext : null,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: currentPage < totalPages ? Colors.grey.shade300 : Colors.grey.shade200,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: currentPage < totalPages ? Colors.grey.shade700 : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
