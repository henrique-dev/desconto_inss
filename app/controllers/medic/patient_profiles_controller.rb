class Medic::PatientProfilesController < MedicApiController
  before_action :set_patient_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_medic!

  # GET /patient_profiles/1
  # GET /patient_profiles/1.json
  def show
  end

  # PATCH/PUT /patient_profiles/1
  # PATCH/PUT /patient_profiles/1.json
  def update
    respond_to do |format|
      if @patient_profile.update(patient_profile_params)
        format.html { redirect_to @patient_profile, notice: 'Patient profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient_profile }
      else
        format.html { render :edit }
        format.json { render json: @patient_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient_profile
      @patient_profile = current_patient.patient_profile
    end

    # Only allow a list of trusted parameters through.
    def patient_profile_params
      params.require(:patient_profile).permit(:name, :genre, :birth_date, :height, :bloodtype, :telephone, :weight)
    end
end
