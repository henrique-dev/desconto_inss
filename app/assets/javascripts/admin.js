//= require jquery
//= require popper.js/dist/umd/popper
//= require bootstrap/dist/js/bootstrap
//= require fastclick/lib/fastclick
//= require nprogress/nprogress
//= require malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar
//= require gentelella

String.prototype.convertCurrencyBrToUs = function() {
    let valor = this.split(".").join("").split(",").join(".").split(" ").join("");
    if (valor.match(/^([0-9]+|[0-9]+\.[0-9]*)$/g) != null) {
        return valor;
    }
    return "0";
}

Number.prototype.cutDecimalPlaces = function(qtd) {
    let valor = String(this);
    let partes = valor.split(".");
    if (partes.length > 1) {
        partes[1] = partes[1].substr(0, qtd);
    }
    return parseFloat(partes.join("."));
}

String.prototype.convertCurrencyUsToBr = function() {
    let arrayTmp = String(this).split(".");
    let real = arrayTmp[0];
    let decimal = ",00";
    if (arrayTmp.length > 1) {
        decimal = "," + arrayTmp[1];
        if (decimal.length == 2) {
            decimal += "0";
        }
    }
    if (real.length > 3) {
        let contador = 0;
        let realTmp = [];
        for (let i=real.length-1; i>=0; i--) {
            realTmp.push(real[i]);
            contador++;
            if (contador == 3) {
                contador = 0;
                if (i > 0) {
                    realTmp.push(".");
                }                
            }
        }
        real = realTmp.reverse().join("");
    }
    return real + decimal;
}