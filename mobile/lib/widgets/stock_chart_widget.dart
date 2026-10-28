import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StockChartWidget extends StatefulWidget {
  const StockChartWidget({super.key});

  @override
  State<StockChartWidget> createState() =>
      _StockChartWidgetState();
}

class _StockChartWidgetState
    extends State<StockChartWidget> {
  String selectedPeriod = "1D";

  List<FlSpot> getChartData() {
    switch (selectedPeriod) {
      case "1D":
        return const [
          FlSpot(0, 210),
          FlSpot(1, 212),
          FlSpot(2, 215),
          FlSpot(3, 214),
          FlSpot(4, 220),
          FlSpot(5, 225),
        ];

      case "5D":
        return const [
          FlSpot(0, 198),
          FlSpot(1, 205),
          FlSpot(2, 212),
          FlSpot(3, 218),
          FlSpot(4, 223),
          FlSpot(5, 225),
        ];

      case "1W":
        return const [
          FlSpot(0, 190),
          FlSpot(1, 200),
          FlSpot(2, 210),
          FlSpot(3, 215),
          FlSpot(4, 225),
          FlSpot(5, 235),
        ];

      case "1M":
        return const [
          FlSpot(0, 160),
          FlSpot(1, 175),
          FlSpot(2, 190),
          FlSpot(3, 210),
          FlSpot(4, 225),
          FlSpot(5, 240),
        ];

      case "3M":
        return const [
          FlSpot(0, 130),
          FlSpot(1, 150),
          FlSpot(2, 175),
          FlSpot(3, 200),
          FlSpot(4, 230),
          FlSpot(5, 255),
        ];

      case "1Y":
        return const [
          FlSpot(0, 90),
          FlSpot(1, 120),
          FlSpot(2, 150),
          FlSpot(3, 190),
          FlSpot(4, 230),
          FlSpot(5, 270),
        ];

      default:
        return const [];
    }
  }

  Widget timeframeButton(String label) {
    final bool selected =
        selectedPeriod == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPeriod = label;
        });
      },
      child: Container(
        padding:
        const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xff2B3139)
              : Colors.transparent,
          borderRadius:
          BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected
                ? Colors.amber
                : Colors.grey,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = getChartData();

    final currentPrice =
    data.last.y.toStringAsFixed(2);

    final percent =
    (((data.last.y - data.first.y) /
        data.first.y) *
        100)
        .toStringAsFixed(2);

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          "\$$currentPrice",
          style: const TextStyle(
            fontSize: 28,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          "+$percent%",
          style: const TextStyle(
            color: Colors.green,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceAround,
          children: [
            timeframeButton("1D"),
            timeframeButton("5D"),
            timeframeButton("1W"),
            timeframeButton("1M"),
            timeframeButton("3M"),
            timeframeButton("1Y"),
          ],
        ),

        const SizedBox(height: 20),

        SizedBox(
          height: 250,
          child: LineChart(
            LineChartData(
              gridData:
              FlGridData(show: false),

              borderData:
              FlBorderData(show: false),

              titlesData:
              FlTitlesData(
                show: false,
              ),

              lineBarsData: [
                LineChartBarData(
                  spots: data,
                  isCurved: true,
                  barWidth: 3,
                  color: Colors.greenAccent,

                  dotData: FlDotData(
                    show: false,
                  ),

                  belowBarData:
                  BarAreaData(
                    show: true,
                    color: Colors
                        .greenAccent
                        .withOpacity(0.15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}