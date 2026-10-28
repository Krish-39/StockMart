import 'package:flutter/material.dart';
import '../services/stock_service.dart';
import '../screens/stock_detail_screen.dart';

class PortfolioCard extends StatefulWidget {
  final String symbol;
  final String company;
  final int shares;

  const PortfolioCard({
    super.key,
    required this.symbol,
    required this.company,
    required this.shares,
  });

  @override
  State<PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard> {
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
      await StockService()
          .getCompanyProfile(widget.symbol);

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
    final total = price * widget.shares;

    return Card(
      margin: const EdgeInsets.only(bottom: 15),

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
              );
            },
          )
              : const Icon(
            Icons.show_chart,
            size: 40,
          ),
        ),

        title: Text(
          widget.company,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          "${widget.symbol}\n${widget.shares} Shares",
        ),

        trailing: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          crossAxisAlignment:
          CrossAxisAlignment.end,
          children: [

            Text(
              "\$${total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 4),

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

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StockDetailScreen(
                symbol: widget.symbol,
                companyName: widget.company,
                price:
                "\$${price.toStringAsFixed(2)}",
                change:
                "${change >= 0 ? "+" : ""}${change.toStringAsFixed(2)}%",
              ),
            ),
          );
        },
      ),
    );
  }
}