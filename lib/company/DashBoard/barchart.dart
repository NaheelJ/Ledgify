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

class ExpensesChart extends StatefulWidget {
  const ExpensesChart({super.key});

  @override
  _ExpensesChartState createState() => _ExpensesChartState();
}

class _ExpensesChartState extends State<ExpensesChart> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000), // Animation duration: 1 second
      vsync: this,
    );

    // Create a Tween animation from 0 to 1
    _animation = Tween<double>(begin:0.0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut, // Smooth easing curve
      ),
    );

    // Start the animation when the widget is built
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10, // Set to 10L as per the chart
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
                                  width: 100,
                                  child: Text(
                                    mainProvider.expenses[value.toInt()].category.toUpperCase(),
                                    style: GoogleFonts.notoSans(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF808080),
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'zł${NumberFormat('#,###').format(mainProvider.expenses[value.toInt()].amount)}',
                                  style: const TextStyle(
                                    color: Color(0xFF808080),
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
                      interval: 1.5,
                      getTitlesWidget: (value, meta) {
                        if (value % 1.5 == 0) {
                          return Text(
                            '${value.toStringAsFixed(1)}L',
                            style: GoogleFonts.notoSans(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF808080),
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
                  horizontalInterval: 1.5,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: Color(0xFFE5E5EF),
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: 0, // Position the line at y = 0L
                      color: clE5E5E5, // Match the color of the axis labels for consistency
                      strokeWidth: 1, // Thickness of the line
                    ),
                  ],
                ),
                borderData: FlBorderData(show: false),
                barGroups: mainProvider.expenses.asMap().entries.map((entry) {
                  final index = entry.key;
                  final expense = entry.value;
                  final barHeight = expense.amount / 100000; // Final height in L units
                  const baseLineHeight = 0.15; // Slightly thicker base line for visibility (in L units)

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: barHeight * _animation.value, // Animate from 0 to final height
                        width: 40,
                        rodStackItems: [
                          // Horizontal line at the base of each bar (optional, can remove if not needed)
                          BarChartRodStackItem(
                            0,
                            baseLineHeight * _animation.value, // Animate the base line height
                            const Color(0xFF5A4EFF), // Darker color for contrast
                          ),
                          // Main bar body
                          BarChartRodStackItem(
                            baseLineHeight * _animation.value,
                            barHeight * _animation.value,
                            Colors.transparent, // Transparent to let the gradient show through
                          ),

                        ],
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
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}