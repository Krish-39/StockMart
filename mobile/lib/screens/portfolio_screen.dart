import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/portfolio_card.dart';
import 'package:fl_chart/fl_chart.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Portfolio"),
        centerTitle: true,
      ),

      bottomNavigationBar: const BottomNav(
        currentIndex: 2,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xff12182B),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [

                  const Text(
                    "Total Portfolio Value",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "\$18,542.60",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: const Text(
                      "+\$352.40 Today",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(

              height: 280,

              child: PieChart(

                PieChartData(

                  centerSpaceRadius: 55,

                  sectionsSpace: 4,

                  sections: [

                    PieChartSectionData(
                      value: 40,
                      color: Colors.blue,
                      radius: 70,
                      title: "40%",
                    ),

                    PieChartSectionData(
                      value: 25,
                      color: Colors.green,
                      radius: 70,
                      title: "25%",
                    ),

                    PieChartSectionData(
                      value: 20,
                      color: Colors.orange,
                      radius: 70,
                      title: "20%",
                    ),

                    PieChartSectionData(
                      value: 15,
                      color: Colors.red,
                      radius: 70,
                      title: "15%",
                    ),

                  ],

                ),

              ),

            ),

            const SizedBox(height: 25),

            Wrap(

              spacing: 20,

              runSpacing: 15,

              children: [

                legendItem(Colors.blue,"Apple"),

                legendItem(Colors.green,"Microsoft"),

                legendItem(Colors.orange,"Tesla"),

                legendItem(Colors.red,"NVIDIA"),

              ],

            ),

            const SizedBox(height: 30),

            const Text(
              "My Holdings",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const PortfolioCard(
              symbol: "AAPL",
              company: "Apple Inc.",
              shares: 10,
            ),

            const PortfolioCard(
              symbol: "TSLA",
              company: "Tesla Inc.",
              shares: 5,
            ),

            const PortfolioCard(
              symbol: "NVDA",
              company: "NVIDIA Corp.",
              shares: 3,
            ),

            const PortfolioCard(
              symbol: "MSFT",
              company: "Microsoft Corp.",
              shares: 9,
            ),

          ],
        ),
      ),
    );
  }
}

Widget legendItem(Color color,String title){

  return Row(

    mainAxisSize: MainAxisSize.min,

    children: [

      Container(

        width:14,

        height:14,

        decoration: BoxDecoration(

          color:color,

          borderRadius: BorderRadius.circular(4),

        ),

      ),

      const SizedBox(width:8),

      Text(title),

    ],

  );

}