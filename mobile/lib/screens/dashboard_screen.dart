import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/live_stock_card.dart';
import '../services/location_service.dart';
import '../widgets/index_card.dart';

class DashboardScreen extends StatelessWidget {
const DashboardScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("StockMart"),
centerTitle: true,
),
bottomNavigationBar: const BottomNav(
currentIndex: 0,
),
body: ListView(
padding: const EdgeInsets.all(20),
children: [
  Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Expanded(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            const Text(
              "Good Morning",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Ajin",
              style: TextStyle(
                fontSize: 30,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      Stack(
        children: [

          const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),

          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration:
              const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    ],
  ),

  FutureBuilder<String>(
    future: LocationService()
        .getCountry(),

    builder: (context, snapshot) {

      if (!snapshot.hasData) {
        return const SizedBox();
      }

      return Padding(
        padding:
        const EdgeInsets.only(top: 8),

        child: Text(
          "📍 ${snapshot.data}",
          style: const TextStyle(
            color: Colors.green,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      );
    },
  ),

const SizedBox(height: 5),

Container(
padding: const EdgeInsets.all(20),
decoration: BoxDecoration(
color: const Color(0xff12182B),
borderRadius: BorderRadius.circular(25),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

const Text(
"Total Portfolio Value",
),

const SizedBox(height: 15),

const Text(
"\$48,291.40",
style: TextStyle(
fontSize: 36,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),

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
"+\$1,234.56 Today",
),
),
],
),
),

const SizedBox(height: 30),

Row(
children: [
Expanded(
child: const IndexCard(
  symbol: "SPY",
  title: "S&P 500",
),
),

const SizedBox(width: 10),

Expanded(
child: const IndexCard(
  symbol: "QQQ",
  title: "NASDAQ",
),
),

const SizedBox(width: 10),

Expanded(
child: const IndexCard(
  symbol: "DIA",
  title: "DOW",
),
),
],
),

const SizedBox(height: 30),

const Text(
"TOP MOVERS",
style: TextStyle(
color: Colors.grey,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),

  const LiveStockCard(
    symbol: "AAPL",
    company: "Apple Inc.",
  ),

  const LiveStockCard(
    symbol: "TSLA",
    company: "Tesla Inc.",
  ),

  const LiveStockCard(
    symbol: "NVDA",
    company: "NVIDIA Corp.",
  ),
],
),
);
}

static Widget marketCard(
String title,
String value,
String change,
Color color,
) {
return Container(
padding: const EdgeInsets.all(15),
decoration: BoxDecoration(
color: const Color(0xff12182B),
borderRadius: BorderRadius.circular(20),
),
child: Column(
children: [
Text(title),
const SizedBox(height: 10),
Text(
value,
style: const TextStyle(
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 5),
Text(
change,
style: TextStyle(
color: color,
),
),
],
),
);
}
}
