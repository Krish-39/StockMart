const STOCKS = [
    // United States
    { symbol: "AAPL", company: "Apple Inc.", country: "US" },
    { symbol: "MSFT", company: "Microsoft Corporation", country: "US" },
    { symbol: "NVDA", company: "NVIDIA Corporation", country: "US" },
    { symbol: "TSLA", company: "Tesla Inc.", country: "US" },
    { symbol: "AMZN", company: "Amazon.com Inc.", country: "US" },
    { symbol: "GOOGL", company: "Alphabet Inc.", country: "US" },

    // Germany
    { symbol: "SAP", company: "SAP SE", country: "DE" },
    { symbol: "SIEGY", company: "Siemens AG", country: "DE" },
    { symbol: "BMWYY", company: "BMW Group", country: "DE" },
    { symbol: "MBGYY", company: "Mercedes-Benz Group", country: "DE" },

    // Japan
    { symbol: "TM", company: "Toyota Motor", country: "JP" },
    { symbol: "SONY", company: "Sony Group", country: "JP" },
    { symbol: "NTDOY", company: "Nintendo", country: "JP" },

    // India
    { symbol: "INFY", company: "Infosys", country: "IN" },

    // United Kingdom
    { symbol: "HSBC", company: "HSBC Holdings", country: "GB" },
    { symbol: "BP", company: "BP plc", country: "GB" },
    { symbol: "UL", company: "Unilever", country: "GB" }
];

let allStocks = [];

async function loadStocks() {
    for (const stock of STOCKS) {
        try {
            const quote = await getQuote(stock.symbol);
            const company = await getCompany(stock.symbol);

            if (!quote || quote.c === 0 || quote.c == null || !company || !company.name) {
                continue;
            }

            const item = { ...stock, quote, company };

            allStocks.push(item);
            displayStocks(allStocks);
        } catch (error) {
            console.log("Skipped:", stock.symbol);
        }
    }
}

function createCard(stock) {
    const positive = stock.quote.dp >= 0;
    return `
        <div class="col-lg-4 col-md-6">
            <a href="stock.html?symbol=${stock.symbol}" class="text-decoration-none">
                <div class="card stock-card h-100">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <img src="${safeUrl(stock.company.logo)}" class="stock-logo" onerror="this.src='assets/logo.png'">
                            <div class="ms-3 flex-grow-1">
                                <h5 class="mb-1 text-white">${escapeHTML(stock.company.name)}</h5>
                                <p class="text-muted mb-0">${stock.symbol}</p>
                            </div>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between align-items-center">
                            <h3 class="mb-0 text-white">$${stock.quote.c.toFixed(2)}</h3>
                            <span class="${positive ? "text-success" : "text-danger"} fw-bold">
                                ${positive ? "+" : ""}${stock.quote.dp.toFixed(2)}%
                            </span>
                        </div>
                    </div>
                </div>
            </a>
        </div>
    `;
}

function displayStocks(stocks) {
    const container = document.getElementById("stocksContainer");
    container.innerHTML = "";
    stocks.forEach(stock => {
        container.innerHTML += createCard(stock);
    });
}

function filterStocks() {
    const search = document.getElementById("searchInput").value.toLowerCase();
    const country = document.getElementById("countryFilter").value;

    const filtered = allStocks.filter(stock => {
        const matchSearch =
            stock.company.name.toLowerCase().includes(search) ||
            stock.symbol.toLowerCase().includes(search);
        const matchCountry = country === "ALL" || stock.country === country;
        return matchSearch && matchCountry;
    });

    displayStocks(filtered);
}

// Market News

async function loadMarketNews() {

    const container = document.getElementById("marketNews");

    container.innerHTML = "";

    try {

        const news = await getNews("AAPL");

        news
            .sort((a, b) => b.datetime - a.datetime)
            .slice(0, 8)
            .forEach(article => {

                const summary = article.summary
                    ? article.summary.substring(0, 140)
                    : "No summary available.";

                const date = new Date(article.datetime * 1000);

                container.innerHTML += `

<div class="col-lg-6">

<div class="card news-card h-100 shadow">

    <img
        src="${safeUrl(article.image)}"
        class="card-img-top"
        style="height:220px;object-fit:cover;"
        onerror="this.style.display='none'">

    <div class="card-body d-flex flex-column">

        <small class="text-success fw-bold">

            ${escapeHTML(article.source)}

        </small>

        <h5 class="mt-2">

            ${escapeHTML(article.headline)}

        </h5>

        <p class="text-muted flex-grow-1">

            ${escapeHTML(summary)}...

        </p>

        <small class="text-secondary mb-3">

            ${date.toLocaleDateString()} • ${date.toLocaleTimeString([], {hour:'2-digit',minute:'2-digit'})}

        </small>

        <a
            href="${safeUrl(article.url)}"
            target="_blank" rel="noopener noreferrer"
            rel="noopener noreferrer"
            class="btn btn-success">

            Read Full Article

        </a>

    </div>

</div>

</div>

`;

            });

    }

    catch (error) {

        container.innerHTML = `

<div class="col-12">

<div class="alert alert-danger">

Unable to load market news.

</div>

</div>

`;

        console.error(error);

    }

}

document.addEventListener("DOMContentLoaded", async () => {

    await loadStocks();

    await loadMarketNews();

    document
        .getElementById("searchInput")
        .addEventListener("input", filterStocks);

    document
        .getElementById("countryFilter")
        .addEventListener("change", filterStocks);

});