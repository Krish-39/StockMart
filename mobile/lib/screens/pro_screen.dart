import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class ProScreen extends StatefulWidget {
  const ProScreen({super.key});

  @override
  State<ProScreen> createState() => _ProScreenState();
}

class _ProScreenState extends State<ProScreen> {
  bool isAnnual = false;

  @override
  Widget build(BuildContext context) {
    final price = isAnnual ? "\$9.99" : "\$14.99";

    return Scaffold(
      appBar: AppBar(
        title: const Text("StockMart Pro"),
        centerTitle: true,
      ),

      bottomNavigationBar: const BottomNav(
        currentIndex: 3,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 10),

            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "StockMart Pro",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Everything you need to invest like a professional.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xff12182B),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Row(
                children: [

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isAnnual = false;
                        });
                      },

                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),

                        decoration: BoxDecoration(
                          color: !isAnnual
                              ? Colors.blue
                              : Colors.transparent,

                          borderRadius:
                          BorderRadius.circular(
                            12,
                          ),
                        ),

                        child: const Center(
                          child: Text(
                            "Monthly",
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isAnnual = true;
                        });
                      },

                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),

                        decoration: BoxDecoration(
                          color: isAnnual
                              ? Colors.blue
                              : Colors.transparent,

                          borderRadius:
                          BorderRadius.circular(
                            12,
                          ),
                        ),

                        child: Center(
                          child: Text(
                            isAnnual
                                ? "Yearly"
                                : "Annual -33%",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Text(
              price,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text(
              "/mo",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              isAnnual
                  ? "Billed yearly · best value"
                  : "Billed monthly · cancel anytime",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            featureCard(
              Icons.access_time,
              Colors.blue,
              "Real-time Data",
              "Live quotes with zero delay, level 2 order book.",
            ),

            featureCard(
              Icons.psychology,
              Colors.green,
              "AI Stock Analysis",
              "Sentiment scoring, earnings prediction, and risk alerts.",
            ),

            featureCard(
              Icons.account_balance_wallet,
              Colors.orange,
              "Advanced Portfolio",
              "Tax optimization, rebalancing, and multi-account sync.",
            ),

            featureCard(
              Icons.notifications,
              Colors.red,
              "Custom Alerts",
              "Price, volume, and pattern-based push notifications.",
            ),

            featureCard(
              Icons.block,
              Colors.indigo,
              "Ad-Free Experience",
              "Enjoy a clean and distraction-free experience.",
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 60,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                ),

                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          isAnnual
                              ? "⭐ Yearly Plan Activated"
                              : "⭐ Monthly Plan Activated",
                        ),

                        content: Text(
                          isAnnual
                              ? "Thank you for subscribing to StockMart Pro Yearly.\n\nPremium features unlocked."
                              : "Thank you for subscribing to StockMart Pro Monthly.\n\nPremium features unlocked.",
                        ),

                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                },

                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(16),

                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff4D8DFF),
                        Color(0xff2ED573),
                      ],
                    ),
                  ),

                  child: const Center(
                    child: Text(
                      "Start Free 7-Day Trial",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Cancel anytime. No charge until trial ends.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget featureCard(
      IconData icon,
      Color color,
      String title,
      String subtitle,
      ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xff12182B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white10,
        ),
      ),

      child: Row(
        children: [

          Container(
            width: 42,
            height: 42,

            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius:
              BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}