class User::Sinan::DiseasesController < UserController

    def index
        @diseases = Diseases::BASE_SINAN_FILES.sort_by{|k,v| v["description"]}.to_h.select{|k,v| v["years"] && v["years"].count > 0}
    end

    def get_years
        render :json => {
            success: true,
            years: Diseases::BASE_SINAN_FILES[params[:disease_id]]["years"]
        }
    end

    def get_data
        base = Diseases.get_base(params[:disease_id], params[:year])
        citys = Diseases.extract_citys(base)

        render :json => {
            success: true,
            base: base,
            citys: citys
        }
    end

    

end