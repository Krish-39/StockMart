# StockMart

This repository contains the combined web and mobile source in [StockMart-web-mobile-source.zip](StockMart-web-mobile-source.zip). Unpack it to get the `web/` PHP/HTML/CSS/JavaScript prototype and the `mobile/` Flutter app (Android, iOS, and Flutter Web).

## Web prototype

Requires PHP 8+. After unpacking, run:

```sh
cd web
php -S 127.0.0.1:8000
```

Open `http://127.0.0.1:8000`. Copy `js/config.example.js` to `js/config.local.js` and set Finnhub/Alpha Vantage keys. The local config is excluded by the included `.gitignore`. The sign-in/register flow is a session-only demo, not production authentication; the project has no persistent user database or payment backend.

## Flutter app

From `mobile/`, run:

```sh
flutter pub get
flutter run --dart-define=FINNHUB_API_KEY=YOUR_FINNHUB_API_KEY
```

Build an Android APK with `flutter build apk --dart-define=FINNHUB_API_KEY=YOUR_FINNHUB_API_KEY`, or the Flutter Web target with `flutter build web --dart-define=FINNHUB_API_KEY=YOUR_FINNHUB_API_KEY`. The app's sign-in and subscription screens are UI prototypes; backend authentication/payment processing are not configured.

## API key safety

API keys are not included. Web keys are visible to browser visitors; use a server-side proxy for a production deployment. Never commit real API keys.
