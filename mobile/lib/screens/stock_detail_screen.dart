import 'package:flutter/material.dart';
import '../widgets/stock_chart_widget.dart';
import '../services/stock_service.dart';
import 'package:flutter/services.dart';

class StockDetailScreen extends StatelessWidget {
  final String symbol;
  final String companyName;
  final String price;
  final String change;

  const StockDetailScreen({
    super.key,
    required this.symbol,
    required this.companyName,
    required this.price,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    final bool positive = !change.contains("-");

    return Scaffold(
      appBar: AppBar(
        title: Text(symbol),
        centerTitle: true,
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                final TextEditingController qtyController =
                TextEditingController(text: "1");
                showDialog(
                  context: context,
                  builder: (context) {


                    if (symbol == "AAPL") {
                    } else if (symbol == "TSLA") {
                    } else if (symbol == "NVDA") {
                    } else if (symbol == "MSFT") {
                    }

                    return AlertDialog(
                      title: Text("Buy $symbol"),

                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          TextField(
                            controller: qtyController,
                            keyboardType: TextInputType.number,

                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],

                            decoration: const InputDecoration(
                              labelText: "Quantity",
                              border: OutlineInputBorder(),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            "Current Price: $price",
                          ),
                        ],
                      ),

                      actions: [

                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),

                        ElevatedButton(
                          onPressed: () {

                            Navigator.pop(context);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Successfully bought ${qtyController.text} shares of $symbol",
                                ),
                              ),
                            );
                          },
                          child: const Text("Buy"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                "Buy $symbol",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              companyName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              price,
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              change,
              style: TextStyle(
                color:
                positive
                    ? Colors.green
                    : Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xff12182B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const StockChartWidget(),
            ),

            const SizedBox(height: 30),

            const Text(
              "Company Information",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            FutureBuilder<Map<String, dynamic>>(
              future: StockService()
                  .getCompanyProfile(symbol),

              builder: (context, snapshot) {

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Text(
                    "Failed to load company information",
                  );
                }

                if (!snapshot.hasData) {
                  return const Text(
                    "No company data available",
                  );
                }

                final company = snapshot.data!;

                return Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Center(
                      child: (company["logo"] != null &&
                          company["logo"].toString().isNotEmpty)
                          ? Image.network(
                        company["logo"],
                        height: 80,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.show_chart,
                            size: 80,
                            color: Colors.green,
                          );
                        },
                      )
                          : const Icon(
                        Icons.show_chart,
                        size: 80,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 20),

                    statRow(
                      "Industry",
                      company["finnhubIndustry"] ??
                          "N/A",
                    ),

                    statRow(
                      "Country",
                      company["country"] ??
                          "N/A",
                    ),

                    statRow(
                      "Exchange",
                      company["exchange"] ??
                          "N/A",
                    ),

                    statRow(
                      "IPO Date",
                      company["ipo"] ??
                          "N/A",
                    ),

                    statRow(
                      "Currency",
                      company["currency"] ??
                          "N/A",
                    ),

                    statRow(
                      "Market Cap",
                      "\$${(company["marketCapitalization"] ?? 0).toStringAsFixed(0)} M",
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "About Company",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                company["name"] != null
                ? "${company["name"]} is traded on ${company["exchange"]}. This asset is denominated in ${company["currency"]} and is associated with the ${company["country"]} market."
                    : "$companyName is a major market instrument that investors use to track market performance.",
                style: const TextStyle(height: 1.5),
                ),

                    const SizedBox(height: 30),

                    const Text(
                      "Latest News",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    FutureBuilder<List<dynamic>>(
                      future: StockService()
                          .getCompanyNews(symbol),

                      builder: (context, snapshot) {

                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        final news = snapshot.data!;

                        return Column(
                          children: news
                              .take(5)
                              .map(
                                (item) => Card(
                              child: ListTile(
                                title: Text(
                                  item["headline"] ?? "",
                                ),
                                subtitle: Text(
                                  item["source"] ?? "",
                                ),
                              ),
                            ),
                          )
                              .toList(),
                        );
                      },
                    ),

                  ],
                );
              },
            ),

          ],
        ),
      ),
    );
  }

  static Widget statRow(
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [
          Text(title),

          Text(
            value,
            style: const TextStyle(
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static Widget newsCard(String title) {
    return Card(
      child: ListTile(
        title: Text(title),

        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}