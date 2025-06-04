import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CryptoChart extends StatelessWidget {
  final List<double> prices;

  const CryptoChart({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    final spots = prices.asMap().entries.map((e) {
      final index = e.key.toDouble();
      final value = e.value;
      return FlSpot(index, value);
    }).toList();

    return AspectRatio(
      aspectRatio: 1.6,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              spots: spots,
              color: Colors.blueAccent,
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
