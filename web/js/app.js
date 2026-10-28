window.onload = () => {
    loadTopMovers();
    loadIndices();
    loadNews();
};

// Top Movers

async function loadTopMovers() {

    const symbols = [
        "AAPL",
        "TSLA",
        "NVDA",
        "MSFT"
    ];

    const container = document.getElementById("stocks");

    container.innerHTML = "";

    for (const symbol of symbols) {

        const quote = await getQuote(symbol);
        const company = await getCompany(symbol);

        container.innerHTML += `

<div class="col-lg-3 col-md-6 mb-4">

<div class="card stock-card h-100"
onclick="openStock('${symbol}')">

<div class="card-body text-center">

<img
src="${safeUrl(company.logo)}"
style="width:60px;height:60px;object-fit:contain;">

<h5 class="mt-3">

${escapeHTML(company.name)}

</h5>

<p class="text-secondary">

${symbol}

</p>

<h3>

$${quote.c.toFixed(2)}

</h3>

<p class="${quote.dp >= 0 ? "text-success" : "text-danger"}">

${quote.dp.toFixed(2)}%

</p>

</div>

</div>

</div>

`;

    }

}

// Indices

async function loadIndices() {

    createIndex("SPY", "spyCard", "S&P 500");

    createIndex("QQQ", "qqqCard", "NASDAQ");

    createIndex("DIA", "diaCard", "DOW");

}

async function createIndex(symbol, id, title) {

    const quote = await getQuote(symbol);

    document.getElementById(id).innerHTML = `

<div class="card">

<div class="card-body text-center">

<h5>

${escapeHTML(title)}

</h5>

<h3>

$${quote.c.toFixed(2)}

</h3>

<p class="${quote.dp >= 0 ? "text-success" : "text-danger"}">

${quote.dp.toFixed(2)}%

</p>

</div>

</div>

`;

}

// News

async function loadNews() {async function loadNews() {

    const news = await getNews("AAPL");

    const container = document.getElementById("news");

    container.innerHTML = "";

    news.slice(0,4).forEach(item => {

        const summary = item.summary
            ? item.summary.substring(0,120)
            : "No summary available.";

        container.innerHTML += `

<div class="card news-card mb-4">

    ${item.image ? `
        <img
            src="${safeUrl(item.image)}"
            class="card-img-top"
            style="height:220px;object-fit:cover;">
    ` : ""}

    <div class="card-body">

        <h5>${escapeHTML(item.headline)}</h5>

        <small class="text-muted">

            ${escapeHTML(item.source)}

        </small>

        <p class="mt-3">

            ${escapeHTML(summary)}...

        </p>

        <a
            href="${safeUrl(item.url)}"
            target="_blank" rel="noopener noreferrer"
            rel="noopener noreferrer"
            class="btn btn-success">

            Read Full Article

        </a>

    </div>

</div>

`;

    });

}

    const news = await getNews("AAPL");

    const container = document.getElementById("news");

    container.innerHTML = "";

    if (!news || news.length === 0) {

        container.innerHTML = `

            <p class="text-center">

                No news available.

            </p>

        `;

        return;

    }

   news.slice(0,4).forEach(item => {

    container.innerHTML += `

<div class="card news-card mb-4">

<div class="card-body">

<h5>

${escapeHTML(item.headline)}

</h5>

<p class="text-muted">

${escapeHTML(item.source)}

</p>

<p>

${escapeHTML(item.summary.substring(0,120))}...

</p>

<a

href="${safeUrl(item.url)}"

target="_blank" rel="noopener noreferrer"

rel="noopener noreferrer"

class="btn btn-success">

Read Full Article

</a>

</div>

</div>

`;

    });

}

// Open Stock Page

function openStock(symbol) {

    window.location.href =
        `stock.html?symbol=${symbol}`;

}