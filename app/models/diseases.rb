class Diseases
    require "csv"

    BASE_PATH = "dados/sinan/"
    
    BASE_SINAN_FILES = {
        "ZIKA" => {
            "description" => "Zika Vírus",
            "years" => [
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "VIOL" => {
            "description" => "Violência",
            "years" => [
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018"
            ]
        },
        "TUBE" => {
            "description" => "Tuberculose",
            "years" => [
                "2001",
                "2002",
                "2003",
                "2004",
                "2005",
                "2006",
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "TETN" => {
            "description" => "Tétano Neonatal",
            "years" => [
                "2015",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "TETA" => {
            "description" => "Tétano Acidental",
            "years" => [
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "RAIV" => {
            "description" => "Raiva",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "PEST" => {
            "description" => "Peste",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017"
            ]
        },
        "PFAN" => {
            "description" => "Paralisia Flácida Aguda"
        },
        "MENI" => {
            "description" => "Meningite",
            "years" => [
                "2006",
                "2007",
                "2008",                
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019",
                "2020"
            ]
        },
        "MALA" => {
            "description" => "Malária",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019",
                "2020"
            ]
        },
        "LEPT" => {
            "description" => "Leptospirose",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "LTAN" => {
            "description" => "Leishmaniose Tegumentar Americana",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018"
            ]
        },                
        "LEIV" => {
            "description" => "Leishmaniose Visceral",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018"
            ]
        },
        "IEXO" => {
            "description" => "Intoxicação Exógena",
            "years" => [
                "2010",                
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019",
                "2020",
            ]
        },
        "INFL" => {
            "description" => "Influenza Pandêmica"
        },
        "HANT" => {
            "description" => "Hantavirose",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017"
            ]
        },
        "HANS" => {
            "description" => "Hanseníase",
            "years" => [
                "2001",
                "2002",
                "2003",
                "2004",
                "2005",
                "2006",
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "FTIF" => {
            "description" => "Febre Tifóide",
            "years" => [
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "FMAC" => {
            "description" => "Febre Maculosa",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017"
            ]
        },
        "FAMA" => {
            "description" => "Febre Amarela",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",                
            ]
        },
        "ESQU" => {
            "description" => "Esquistossomose",
            "years" => [                
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017"
            ]
        },
        "CHAG" => {
            "description" => "Doença de Chagas Aguda",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "DIFT" => {
            "description" => "Difteria",
            "years" => [
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "DENG" => {
            "description" => "Dengue",
            "years" => [
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "COQU" => {
            "description" => "Coqueluche",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "COLE" => {
            "description" => "Cólera",
            "years" => [
                "2007",
                "2008",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "CHIK" => {
            "description" => "Febre de Chikungunya",
            "years" => [
                "2015",
                "2016",
                "2017",
                "2018",
                "2019"
            ]
        },
        "BOTU" => {
            "description" => "Botulismo",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019",
            ]
        },
        "ANIM" => {
            "description" => "Acidente por Animais Peçonhentos",
            "years" => [
                "2007",
                "2008",
                "2009",
                "2010",
                "2011",
                "2012",
                "2013",
                "2014",
                "2015",
                "2016",
                "2017",
                "2018",
                "2019",
            ]
        },
    }

    CITYS = {
        "160005" => {
            "description" => "Serra do Navio"
        },
        "160010" => {
            "description" => "Amapá"
        },
        "160015" => {
            "description" => "Pedra Branca do Amapari"
        },
        "160020" => {
            "description" => "Calçoene"
        },
        "160021" => {
            "description" => "Cutias"
        },
        "160023" => {
            "description" => "Ferreira Gomes"
        },
        "160025" => {
            "description" => "Itaubal"
        },
        "160027" => {
            "description" => "Laranjal do Jari"
        },
        "160030" => {
            "description" => "Macapá"
        },
        "160040" => {
            "description" => "Mazagão"
        },
        "160050" => {
            "description" => "Oiapoque"
        },
        "160053" => {
            "description" => "Porto Grande"
        },
        "160055" => {
            "description" => "Pracuúba"
        },
        "160060" => {
            "description" => "Santana"
        },
        "160070" => {
            "description" => "Tartarugalzinho"
        },
        "160080" => {
            "description" => "Vitória do Jari"
        }
    }
        
   

    def self.csv_to_array base, sub, year
        
    end

    def self.get_base disease_id, year
        file_name = disease_id + "AP" + year.to_s[2,2] + ".csv"
        #array_csv = CSV.read(BASE_PATH + BASE_SINAN_FILES[disease_id]["paths"][year], {:encoding => 'ISO-8859-1'})
        array_csv = CSV.read(BASE_PATH + file_name, {:encoding => 'ISO-8859-1'})
        keys = array_csv[0]
        array_objects = []
        array_csv.reverse!
        array_csv.pop
        array_csv.each do |row|
            object = {}
            index = 0
            row.each do |col|
                object[keys[index]] = col
                index += 1
            end
            array_objects << object
        end
        {
            :header => keys,
            :body => array_objects
        }
    end

    def self.extract_citys base
        array_citys = []
        hash_citys = {}
        base[:body].each do |row|
            puts "heeeeeeeeere".yellow
            p row
            p row["ID_MUNICIP"]
            hash_citys[row["ID_MUNICIP"]] = true
        end
        hash_citys.keys.each do |city_id|
            if (Diseases::CITYS[city_id])
                puts Diseases::CITYS[city_id]["description"]
                array_citys << {
                    :id => city_id,
                    :description => Diseases::CITYS[city_id]["description"]
                }
            end
        end
        array_citys
    end

end