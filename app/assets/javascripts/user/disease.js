//= require jquery

var chart;
var valueAxis;
var categoryAxis;

function processaDados(acao, dados, complemento = null, complemento2 = null) {

  let link = null;
  let json = null;
  let container = null;
  let posEnvio = null;

  switch (acao) {
    case "GET_YEARS" :
      link = "diseases/get_years?disease_id=" + dados;
      break;
    case "GET_DATA" :
      link = "diseases/get_data?disease_id=" + dados.disease_id + "&year=" + dados.year;
      break;
  }
  
  jQuery.get( link, json, function( dadosRecebidos ) {      
    processaRetornoAJAX(acao, dadosRecebidos, posEnvio);
  }, "json").fail(function(e) {
    alert("Ocorreu um erro durante este processo. Entre em contato com nossa equipe no suporte on-line.");
  });
}

function processaRetornoAJAX(acao, dados, complemento) {
  if (dados.success) {
    switch (acao) {
      case "GET_YEARS" :
        jQuery("#select_ano_cod").removeAttr("disabled");
        jQuery("#select_ano_cod").empty().append(
          "<option value=''></option>"
        );
        dados.years.forEach(element => {
          jQuery("#select_ano_cod").append(
             "<option value='"+ element +"'>"+ element +"</option>"
          );
        });
        jQuery("#select_ano_cod").off().change(function() {
          let yearCod = jQuery(this).val();
          let diseaseId = jQuery("#select_disease_id").val();
          if (yearCod != "" && diseaseId != "") {
            processaDados("GET_DATA", {
              disease_id: diseaseId,
              year: yearCod
            });
          }    
        });
        break;
      case "GET_DATA" :
        jQuery("#select_city_id").removeAttr("disabled");
        jQuery("#select_city_id").empty().append(
          "<option value=''>Todas</option>"
        );
        dados.citys.forEach(element => {
          jQuery("#select_city_id").append(
             "<option value='"+ element.id +"'>"+ element.description +"</option>"
          );
        });
        jQuery("#select_city_id").off().change(function() {
          loadChart(dados);  
        });        
        loadChart(dados);
        break;
    }
  }
}

function mountData(dados, cityId = null) {
  let hashCitys = {};
  let hashByMonth = {
    0: 0,
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0,
    9: 0,
    10: 0,
    11: 0
  };

  dados.base.body.forEach(element => {
    //console.log(element);
    if (element["DT_NOTIFIC"] != "") {
      let notifyDate = new Date(element["DT_NOTIFIC"].substr(0,4) + "-" + element["DT_NOTIFIC"].substr(4,2) + "-" + element["DT_NOTIFIC"].substr(6,2));
      notifyDate.setDate(notifyDate.getDate() + 1);      
      if (cityId != "") {
        if (element["ID_MUNICIP"] == cityId) {
          hashByMonth[notifyDate.getMonth()] += 1;
        }
      } else {
        hashByMonth[notifyDate.getMonth()] += 1;
      }          
    }
  });
  return [{
    "months": "Janeiro",
    "litres": hashByMonth[0]
  }, {
    "months": "Fevereiro",
    "litres": hashByMonth[1]
  }, {
    "months": "Março",
    "litres": hashByMonth[2]
  }, {
    "months": "Abril",
    "litres": hashByMonth[3]
  }, {
    "months": "Maio",
    "litres": hashByMonth[4]
  }, {
    "months": "Junho",
    "litres": hashByMonth[5]
  }, {
    "months": "Julho",
    "litres": hashByMonth[6]
  }, {
    "months": "Agosto",
    "litres": hashByMonth[7]
  }, {
    "months": "Setembro",
    "litres": hashByMonth[8]
  }, {
    "months": "Outubro",
    "litres": hashByMonth[9]
  }, {
    "months": "Novembro",
    "litres": hashByMonth[10]
  }, {
    "months": "Dezembro",
    "litres": hashByMonth[11]
  }];
}

function loadChart(dados) {
  //console.log(dados);

  let cityId = jQuery("#select_city_id").val();
  //var chart = am4core.create("chartdiv", am4charts.XYChart);
  
  chart.data = mountData(dados, cityId);
  valueAxis.title.text = "Quantidade de casos notificados no ano de " + jQuery("#select_ano_cod").val();
  categoryAxis.title.text = jQuery("#select_city_id").find(":selected").text();
  
}

jQuery(document).ready(function() {
  jQuery("#select_disease_id").change(function() {
    let diseaseId = jQuery(this).val();
    if (diseaseId != "") {
      processaDados("GET_YEARS", diseaseId);
    }    
  });

  chart = am4core.create("chartdiv", am4charts.XYChart);  

  chart.data = [{
    "months": "Janeiro",
    "litres": 0
  }, {
    "months": "Fevereiro",
    "litres": 0
  }, {
    "months": "Março",
    "litres": 0
  }, {
    "months": "Abril",
    "litres": 0
  }, {
    "months": "Maio",
    "litres": 0
  }, {
    "months": "Junho",
    "litres": 0
  }, {
    "months": "Julho",
    "litres": 0
  }, {
    "months": "Agosto",
    "litres": 0
  }, {
    "months": "Setembro",
    "litres": 0
  }, {
    "months": "Outubro",
    "litres": 0
  }, {
    "months": "Novembro",
    "litres": 0
  }, {
    "months": "Dezembro",
    "litres": 0
  }];

  categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
  categoryAxis.dataFields.category = "months";  

  valueAxis = chart.yAxes.push(new am4charts.ValueAxis());  

  var series = chart.series.push(new am4charts.ColumnSeries());
  series.name = "Sales";
  //series.columns.template.tooltipText = "Series: {name}\nCategory: {categoryX}\nValue: {valueY}";
  series.columns.template.tooltipText = "Quantidade de casos: {valueY}";
  series.columns.template.fill = am4core.color("#DE3163"); // fill
  series.dataFields.valueY = "litres";
  series.dataFields.categoryX = "months";

});