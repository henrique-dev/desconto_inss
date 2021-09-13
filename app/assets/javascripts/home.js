//= require jquery
//= require chart.js

jQuery(document).ready(function() {
    var ctx = $('#chart_plot');

    let labels = [];
    let data = [];
    ranges.forEach(function(range, index) {
        if (index+1 == ranges.length) {
            labels.push(String(parseFloat(ranges[index-1]["v"]) + 0.01).convertCurrencyUsToBr());
            data.push(range["q"]);
        } else {
            labels.push(String(range["v"]).convertCurrencyUsToBr());
            data.push(range["q"]);
        }
    });

    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: "Distribuição de renda",
                data: data,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
})