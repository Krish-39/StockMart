import 'package:flutter/material.dart';
import '../services/stock_service.dart';
import '../screens/stock_detail_screen.dart';

class LiveStockCard extends StatefulWidget {
  final String symbol;
  final String company;

  const LiveStockCard({
    super.key,
    required this.symbol,
    required this.company,
  });

  @override
  State<LiveStockCard> createState() => _LiveStockCardState();
}

class _LiveStockCardState extends State<LiveStockCard> {

  double price = 0;
  double change = 0;
  String logo = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final quote =
      await StockService().getQuote(widget.symbol);

      final profile =
      await StockService().getCompanyProfile(widget.symbol);

      setState(() {
        price = (quote["c"] ?? 0).toDouble();
        change = (quote["dp"] ?? 0).toDouble();
        logo = profile["logo"] ?? "";
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    final bool positive = change >= 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),

      child: ListTile(

        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),

          child: logo.isNotEmpty
              ? Image.network(
            logo,
            width: 45,
            height: 45,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return const Icon(
                Icons.show_chart,
                size: 40,
                color: Colors.green,
              );
            },
          )
              : const Icon(
            Icons.show_chart,
            size: 40,
            color: Colors.green,
          ),
        ),

        title: Text(
          widget.company,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(widget.symbol),

        trailing: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          crossAxisAlignment:
          CrossAxisAlignment.end,

          children: [

            Text(
              "\$${price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "${positive ? "+" : ""}${change.toStringAsFixed(2)}%",
              style: TextStyle(
                color:
                positive ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        onTap: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StockDetailScreen(
                symbol: widget.symbol,
                companyName: widget.company,
                price: "\$${price.toStringAsFixed(2)}",
                change:
                "${positive ? "+" : ""}${change.toStringAsFixed(2)}%",
              ),
            ),
          );

        },
      ),
    );
  }
}