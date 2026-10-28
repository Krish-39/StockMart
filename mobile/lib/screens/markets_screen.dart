import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/live_stock_card.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() =>
      _MarketsScreenState();
}

class _MarketsScreenState
    extends State<MarketsScreen> {

  final List<Map<String, String>> stocks = [
    {
      "symbol": "AAPL",
      "company": "Apple Inc.",
    },
    {
      "symbol": "TSLA",
      "company": "Tesla Inc.",
    },
    {
      "symbol": "NVDA",
      "company": "NVIDIA Corp.",
    },
    {
      "symbol": "MSFT",
      "company": "Microsoft Corp.",
    },
  ];

  String searchText = "";

  @override
  Widget build(BuildContext context) {

    final filteredStocks = stocks.where((stock) {
      return stock["symbol"]!
          .toLowerCase()
          .contains(
        searchText.toLowerCase(),
      ) ||
          stock["company"]!
              .toLowerCase()
              .contains(
            searchText.toLowerCase(),
          );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Markets"),
        centerTitle: true,
      ),

      bottomNavigationBar: const BottomNav(
        currentIndex: 1,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          children: [

            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },

              decoration: InputDecoration(
                hintText: "Search Stocks...",
                prefixIcon:
                const Icon(Icons.search),

                filled: true,
                fillColor:
                const Color(0xff12182B),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                    15,
                  ),
                  borderSide:
                  BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Stocks",
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ...filteredStocks.map(
                  (stock) => LiveStockCard(
                symbol: stock["symbol"]!,
                company: stock["company"]!,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Top News",
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            newsCard(
              "MARKETS",
              "Fed signals potential rate cuts; tech stocks rally on positive earnings outlook",
              "Reuters",
            ),

            newsCard(
              "TECH",
              "Apple unveils new AI features for iPhone",
              "Bloomberg",
            ),

            newsCard(
              "MARKETS",
              "Tesla deliveries miss estimates",
              "CNBC",
            ),
          ],
        ),
      ),
    );
  }

  static Widget newsCard(
      String category,
      String title,
      String source,
      ) {
    return Card(
      margin:
      const EdgeInsets.only(bottom: 12),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(
              category,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(title),

            const SizedBox(height: 8),

            Text(
              source,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}