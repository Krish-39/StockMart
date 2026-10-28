import 'package:flutter/material.dart';
import '../services/stock_service.dart';
import '../screens/stock_detail_screen.dart';

class IndexCard extends StatelessWidget {
  final String symbol;
  final String title;

  const IndexCard({
    super.key,
    required this.symbol,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: StockService().getQuote(symbol),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 120,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xff12182B),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final data = snapshot.data!;

        final price = (data["c"] ?? 0).toDouble();
        final change = (data["dp"] ?? 0).toDouble();

        return GestureDetector(
          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => StockDetailScreen(
                  symbol: symbol,
                  companyName: title,
                  price: "\$${price.toStringAsFixed(2)}",
                  change:
                  "${change >= 0 ? "+" : ""}${change.toStringAsFixed(2)}%",
                ),
              ),
            );

          },

          child: Container(
            padding: const EdgeInsets.all(15),

            decoration: BoxDecoration(
              color: const Color(0xff12182B),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  price.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "${change >= 0 ? "+" : ""}${change.toStringAsFixed(2)}%",
                  style: TextStyle(
                    color: change >= 0
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}