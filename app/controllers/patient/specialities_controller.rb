class Patient::SpecialitiesController < PatientApiController
  before_action :set_speciality, only: [:show, :edit, :update, :destroy]

  # GET /specialities
  # GET /specialities.json
  def index
    @specialities = Speciality.all.joins(:medic_work_schedulings).distinct
  end

  # GET /specialities/1
  # GET /specialities/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_speciality
      @speciality = Speciality.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def speciality_params
      params.require(:speciality).permit(:description, :priv)
    end
end
