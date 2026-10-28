# StockMart

This repository contains two StockMart clients side by side: a PHP/HTML/CSS/JavaScript web prototype in `web/`, and a Flutter app in `mobile/` that targets Android, iOS, and Flutter Web. They are separate frontends; they do not share a backend or account database.

## Web prototype

The web version includes a dashboard, markets and stock detail pages, portfolio, and sign-in/register screens. It uses Finnhub and Alpha Vantage API calls from browser JavaScript.

Run it locally with PHP 8+:

```sh
cd web
php -S 127.0.0.1:8000
```

Open `http://127.0.0.1:8000`. Copy `web/js/config.example.js` to `web/js/config.local.js`, add your Finnhub and Alpha Vantage keys, and keep the local config file untracked.

Accounts are stored in a SQLite database at `data/stockmart.sqlite` (created on first run, outside the web root, gitignored). Passwords are hashed with `password_hash`, forms carry a CSRF token, and the session id is regenerated on login. PHP needs the `pdo_sqlite` extension, which ships with most PHP builds. This is still a demo: there is no email verification, password reset or payment integration.

### Project layout

```
web/
  index.html, markets.html, stock.html, pro.html   static pages
  login.php, register.php, logout.php, portfolio.php
  includes/auth.php      database, session and CSRF helpers
  js/api.js              Finnhub / Alpha Vantage calls, HTML escaping helpers
mobile/                  Flutter app (lib/, android/, ios/, web/ ...)
```

## Flutter app

Prerequisites: Flutter SDK. From `mobile/` run:

```sh
flutter pub get
flutter run --dart-define=FINNHUB_API_KEY=YOUR_FINNHUB_API_KEY
```

Build for Android with:

```sh
flutter build apk --dart-define=FINNHUB_API_KEY=YOUR_FINNHUB_API_KEY
```

Build its web target with `flutter build web --dart-define=FINNHUB_API_KEY=YOUR_FINNHUB_API_KEY`. Build output is generated locally and is not committed. The app's sign-in and subscription screens are UI flows; backend authentication and payment processing are not configured.

## API keys

Never commit API keys. Web client keys are visible to visitors in browser network requests, so use a server-side API proxy for a production deployment.

## License

[MIT](LICENSE)
