
// Demo portfolio holdings
const holdings = [

    { symbol: "AAPL", shares: 10 },

    { symbol: "MSFT", shares: 8 },

    { symbol: "NVDA", shares: 3 },

    { symbol: "TSLA", shares: 5 }

];

let allocationChart = null;

async function loadPortfolio() {

    const container = document.getElementById("holdings");

    container.innerHTML = "";

    let portfolioTotal = 0;

    let todayGain = 0;

    const chartLabels = [];

    const chartData = [];

    for (const item of holdings) {

        try {

            const quote = await getQuote(item.symbol);

            const company = await getCompany(item.symbol);

            const value = quote.c * item.shares;

            const gain = quote.d * item.shares;

            portfolioTotal += value;

            todayGain += gain;

            chartLabels.push(item.symbol);

            chartData.push(value);

            container.innerHTML += `

<div class="col-lg-6">

<div class="stock-card">

<div class="d-flex align-items-center">

<img
src="${safeUrl(company.logo)}"
class="stock-logo"
onerror="this.src='assets/logo.png'">

<div class="ms-3">

<h5>${escapeHTML(company.name)}</h5>

<p class="text-muted mb-0">

${item.shares} Shares

</p>

</div>

</div>

<hr>

<div class="d-flex justify-content-between">

<h4>

$${value.toFixed(2)}

</h4>

<span class="${gain >= 0 ? "up" : "down"}">

${gain >= 0 ? "+" : ""}$${gain.toFixed(2)}

</span>

</div>

</div>

</div>

`;

        }

        catch (error) {

            console.log(error);

        }

    }

    document.getElementById("portfolioValue").textContent =

        "$" + portfolioTotal.toFixed(2);

    document.getElementById("todayGain").textContent =

        `${todayGain >= 0 ? "+" : ""}$${todayGain.toFixed(2)} Today`;

    drawAllocation(chartLabels, chartData);

}

function drawAllocation(labels, values) {

    const ctx = document

        .getElementById("portfolioChart")

        .getContext("2d");

    if (allocationChart) {

        allocationChart.destroy();

    }

    allocationChart = new Chart(ctx, {

        type: "pie",

        data: {

            labels,

            datasets: [{

                data: values

            }]

        },

        options: {

            responsive: true,

            plugins: {

                legend: {

                    position: "bottom",

                    labels: {

                        color: "#ffffff"

                    }

                }

            }

        }

    });

}

document.addEventListener("DOMContentLoaded", () => {

    loadPortfolio();

});