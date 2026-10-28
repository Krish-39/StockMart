import 'dart:convert';
import 'package:http/http.dart' as http;

class StockService {
  static const String apiKey = String.fromEnvironment('FINNHUB_API_KEY');

  Future<Map<String, dynamic>> getQuote(
      String symbol) async {
    final url = Uri.parse(
      "https://finnhub.io/api/v1/quote?symbol=$symbol&token=$apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load quote");
  }

  Future<Map<String, dynamic>> getCompanyProfile(
      String symbol) async {
    final url = Uri.parse(
      "https://finnhub.io/api/v1/stock/profile2?symbol=$symbol&token=$apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load profile");
  }

  Future<List<dynamic>> getCompanyNews(
      String symbol) async {

    final today = DateTime.now();

    final from = DateTime(
      today.year,
      today.month,
      today.day - 7,
    );

    final url = Uri.parse(
      "https://finnhub.io/api/v1/company-news"
          "?symbol=$symbol"
          "&from=${from.toIso8601String().split('T')[0]}"
          "&to=${today.toIso8601String().split('T')[0]}"
          "&token=$apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load news");
  }

  Future<Map<String, dynamic>> getHistoricalChart(
      String symbol,
      String resolution) async {

    final now = DateTime.now();

    int from;

    switch (resolution) {
      case "5":
        from = now
            .subtract(const Duration(days: 1))
            .millisecondsSinceEpoch ~/
            1000;
        break;

      case "60":
        from = now
            .subtract(const Duration(days: 7))
            .millisecondsSinceEpoch ~/
            1000;
        break;

      case "D":
        from = now
            .subtract(const Duration(days: 30))
            .millisecondsSinceEpoch ~/
            1000;
        break;

      case "W":
        from = now
            .subtract(const Duration(days: 365))
            .millisecondsSinceEpoch ~/
            1000;
        break;

      default:
        from = now
            .subtract(const Duration(days: 30))
            .millisecondsSinceEpoch ~/
            1000;
    }

    final to = now.millisecondsSinceEpoch ~/ 1000;

    final url = Uri.parse(
      "https://finnhub.io/api/v1/stock/candle"
          "?symbol=$symbol"
          "&resolution=$resolution"
          "&from=$from"
          "&to=$to"
          "&token=$apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load chart");
  }
}