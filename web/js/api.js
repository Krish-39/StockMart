const API_KEY = window.STOCKMART_API_CONFIG?.FINNHUB_API_KEY ?? "";
const ALPHA_API_KEY = window.STOCKMART_API_CONFIG?.ALPHA_VANTAGE_API_KEY ?? "";

// Third-party API data (news, company profiles) is untrusted: escape it before
// it goes into innerHTML, and only allow http(s) links and images.
function escapeHTML(value) {
    return String(value ?? "")
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#39;");
}

function safeUrl(value) {
    try {
        const url = new URL(String(value ?? ""), window.location.href);
        return url.protocol === "http:" || url.protocol === "https:"
            ? escapeHTML(url.href)
            : "#";
    } catch {
        return "#";
    }
}


async function getQuote(symbol) {
    const response = await fetch(
        `https://finnhub.io/api/v1/quote?symbol=${encodeURIComponent(symbol)}&token=${API_KEY}`
    );

    return await response.json();
}

async function getCompany(symbol) {
    const response = await fetch(
        `https://finnhub.io/api/v1/stock/profile2?symbol=${encodeURIComponent(symbol)}&token=${API_KEY}`
    );

    return await response.json();
}

async function getNews(symbol) {

    const today = new Date();

    const weekAgo = new Date();

    weekAgo.setDate(today.getDate() - 7);

    const from = weekAgo.toISOString().split("T")[0];

    const to = today.toISOString().split("T")[0];

    const response = await fetch(
        `https://finnhub.io/api/v1/company-news?symbol=${encodeURIComponent(symbol)}&from=${from}&to=${to}&token=${API_KEY}`
    );

    return await response.json();
}

async function getCandle(symbol, resolution = "D") {

    const now = Math.floor(Date.now() / 1000);

    let from = now - 30 * 24 * 60 * 60;

    if (resolution === "5")
        from = now - 24 * 60 * 60;

    if (resolution === "60")
        from = now - 7 * 24 * 60 * 60;

    if (resolution === "W")
        from = now - 365 * 24 * 60 * 60;

    const response = await fetch(
        `https://finnhub.io/api/v1/stock/candle?symbol=${encodeURIComponent(symbol)}&resolution=${resolution}&from=${from}&to=${now}&token=${API_KEY}`
    );

    return await response.json();
}

// Alpha Vantage Historical Chart

async function getChart(symbol) {

    const response = await fetch(

        `https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=${encodeURIComponent(symbol)}&outputsize=compact&apikey=${ALPHA_API_KEY}`

    );

    return await response.json();

}
