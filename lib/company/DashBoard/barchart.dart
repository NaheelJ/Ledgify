import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../constants/myColors.dart';


/*

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<MainProvider>(
              builder: (context, expensesProvider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expenses : zł${NumberFormat('#,###').format(expensesProvider.totalExpenses)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            DateFormat('MMMM, yyyy').format(DateTime.now()),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.calendar_today, size: 16),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            const Expanded(
              child: ExpensesChart(),
            ),
          ],
        ),
      ),
    );
  }
}
*/

class ExpensesChart extends StatelessWidget {
  const ExpensesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: mainProvider.maxExpenseValue,
            minY: 0,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final category = mainProvider.expenses[groupIndex].category;
                  final amount = NumberFormat('zł#,###').format(mainProvider.expenses[groupIndex].amount);
                  return BarTooltipItem(
                    '$category\n$amount',
                    const TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 85,
                  getTitlesWidget: (value, meta) {
                    if (value >= 0 && value < mainProvider.expenses.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 250,
                              child: Text(
                                mainProvider.expenses[value.toInt()].category,
                                style: GoogleFonts.notoSans(textStyle:TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400,color: cl808080) ) ,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'zł${NumberFormat('#,###').format(mainProvider.expenses[value.toInt()].amount)}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    // Only show titles at 1.5L intervals
                    if (value % 1 == 0) {
                      return Text(
                        '${value.toStringAsFixed(1)}L',
                        style: GoogleFonts.notoSans(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: cl808080,
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              horizontalInterval: 1,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: clE5E5EF,
                  strokeWidth: 1,
                  dashArray: [5, 5],
                );
              },
            ),
            borderData: FlBorderData(show: false),
            barGroups: mainProvider.expenses.asMap().entries.map((entry) {
              final index = entry.key;
              final expense = entry.value;
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(

                    toY: expense.amount / 100000, // Convert to L units
                    width: 40,

                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFBDB7FF), // 0%
                        Color(0xFFA8A1FF), // 41.69%
                        Color(0xFF7E72FF), // 62.67%
                      ],
                      stops: [0.0, 0.4169, 0.6267],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );

  }
}

