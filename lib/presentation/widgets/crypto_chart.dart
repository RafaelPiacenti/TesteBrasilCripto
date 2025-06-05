import 'package:auto_size_text/auto_size_text.dart';
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

    final minY = prices.reduce((a, b) => a < b ? a : b);
    final maxY = prices.reduce((a, b) => a > b ? a : b);

    return AspectRatio(
      aspectRatio: 1.6,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            horizontalInterval: (maxY - minY) / 4,
            getDrawingHorizontalLine: (_) => FlLine(
              color: Colors.grey.withValues(alpha: 0.2),
              strokeWidth: 1,
            ),
            getDrawingVerticalLine: (_) => FlLine(
              color: Colors.grey.withValues(alpha: 0.2),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (spots.length / 6).floorToDouble(),
                getTitlesWidget: (value, _) {
                  final totalPoints = prices.length;
                  final index = value.toInt();

                  if (index < 0 || index >= totalPoints) {
                    return const SizedBox.shrink();
                  }

                  final now = DateTime.now();
                  final hoursFromEnd = totalPoints - index - 1;
                  final date = now.subtract(Duration(hours: hoursFromEnd));

                  final label =
                      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';

                  return Text(label, style: const TextStyle(fontSize: 10));
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 48,
                interval: (maxY - minY) / 4,
                getTitlesWidget: (value, _) => AutoSizeText(
                  value.toStringAsFixed(2),
                  maxLines: 1,
                  minFontSize: 8,
                ),
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.black26),
              bottom: BorderSide(color: Colors.black26),
            ),
          ),
          minY: minY,
          maxY: maxY,
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
