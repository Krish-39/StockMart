// StockMart - Stock Details

const params = new URLSearchParams(window.location.search);

// Get stock symbol from URL
const symbol = params.get("symbol") || "AAPL";

let currentPrice = 0;
let stockChart = null;

async function drawChart(range = "1M") {

    const data = await getChart(symbol);

    if (!data["Time Series (Daily)"]) {

        console.log(data);

        return;

    }

    const series = data["Time Series (Daily)"];

    let dates = Object.keys(series);

    dates.sort();

    if (range === "1D") {

        dates = dates.slice(-1);

    }

    if (range === "1M") {

        dates = dates.slice(-30);

    }

    if (range === "3M") {

        dates = dates.slice(-90);

    }

    if (range === "1Y") {

        dates = dates.slice(-250);

    }

    const labels = [];
    const prices = [];

    dates.forEach(date => {

        labels.push(date);

        prices.push(

            parseFloat(series[date]["4. close"])

        );

    });

    const ctx = document
        .getElementById("stockChart")
        .getContext("2d");

    if (stockChart) {

        stockChart.destroy();

    }

    stockChart = new Chart(ctx, {

        type: "line",

        data: {

            labels,

            datasets: [{

                data: prices,

                borderColor: "#00C853",

                backgroundColor: "rgba(0,200,83,.15)",

                fill: true,

                tension: .35,

                pointRadius: 0,

                borderWidth: 3

            }]

        },

        options: {

            responsive: true,

            maintainAspectRatio: false,

            plugins: {

                legend: {

                    display: false

                }

            },

            scales: {

                x: {

                    ticks: {

                        color: "#9CA3AF"

                    },

                    grid: {

                        color: "#1C2336"

                    }

                },

                y: {

                    ticks: {

                        color: "#9CA3AF"

                    },

                    grid: {

                        color: "#1C2336"

                    }

                }

            }

        }

    });

}

// Load stock page
async function loadStock() {

    try {

        const quote = await getQuote(symbol);
        const company = await getCompany(symbol);

        // Logo
        document.getElementById("companyLogo").src =
           company.logo || "assets/logo.png"

        // Name
        document.getElementById("companyName").textContent =
            company.name || symbol;

        // Symbol
        document.getElementById("companySymbol").textContent =
            symbol;

        // Price
        currentPrice = quote.c;
        document.getElementById("stockPrice").textContent =
            "$" + quote.c.toFixed(2);

        // Daily Change
        const change = document.getElementById("stockChange");

        change.textContent =
            `${quote.dp >= 0 ? "+" : ""}${quote.dp.toFixed(2)}%`;

        change.className =
            quote.dp >= 0 ? "up" : "down";

        // Statistics
        document.getElementById("openPrice").textContent =
            "$" + quote.o.toFixed(2);

        document.getElementById("highPrice").textContent =
            "$" + quote.h.toFixed(2);

        document.getElementById("lowPrice").textContent =
            "$" + quote.l.toFixed(2);

        document.getElementById("previousClose").textContent =
            "$" + quote.pc.toFixed(2);

        // Company Info
        document.getElementById("exchange").textContent =
            company.exchange || "-";

        document.getElementById("country").textContent =
            company.country || "-";

        document.getElementById("ipo").textContent =
            company.ipo || "-";

        document.getElementById("marketCap").textContent =
            company.marketCapitalization
                ? company.marketCapitalization + " B"
                : "-";

        document.getElementById("website").innerHTML =
            `<a href="${safeUrl(company.weburl)}" target="_blank" rel="noopener noreferrer">${escapeHTML(company.weburl)}</a>`;

            await drawChart();

            await loadNews();



    }

    catch (error) {

        console.error(error);

    }

    

}

function updateTotal(){

    const quantity = Number(
        document.getElementById("quantity").value
    );

    document.getElementById("totalPrice").textContent =
        "$" + (quantity * currentPrice).toFixed(2);

}


// Load Company News

async function loadNews() {

    const news = await getNews(symbol);

    const container = document.getElementById("companyNews");

    container.innerHTML = "";

    if (!news || news.length === 0) {

        container.innerHTML = `

            <p class="text-muted">

                No news available.

            </p>

        `;

        return;

    }

    news.slice(0,5).forEach(article => {

        container.innerHTML += `

            <div class="news-card mb-3">

                <h5>

                    ${escapeHTML(article.headline)}

                </h5>

                <p>

                    ${escapeHTML(article.summary)}

                </p>

                <a
                    href="${safeUrl(article.url)}"
                    target="_blank" rel="noopener noreferrer">

                    Read Full Article →

                </a>

            </div>

        `;

    });

}

document.addEventListener("DOMContentLoaded", async () => {

    await loadStock();

    // Chart buttons
    document.querySelectorAll(".chart-btn").forEach(button => {

        button.addEventListener("click", async () => {

            document
                .querySelectorAll(".chart-btn")
                .forEach(btn => btn.classList.remove("active"));

            button.classList.add("active");

            await drawChart(button.dataset.range);

        });

    });

    // Buy quantity
    document
        .getElementById("quantity")
        .addEventListener("input", updateTotal);

    // Buy confirmation
    document
        .getElementById("confirmBuy")
        .addEventListener("click", () => {

            alert("Purchase Successful!");

        });

});