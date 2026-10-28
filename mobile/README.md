# StockMart Flutter app

Flutter client for Android, iOS, and Flutter Web. The app requests quotes, company profiles, company news, and historical candles from Finnhub.

## Run locally

```sh
flutter pub get
flutter run --dart-define=FINNHUB_API_KEY=YOUR_FINNHUB_API_KEY
```

Do not commit API keys. The sign-in and subscription pages are UI prototypes; backend authentication and payment processing are not configured. See the repository root README for the combined web/mobile layout and web setup.
