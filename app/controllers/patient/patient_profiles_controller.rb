class Patient::PatientProfilesController < PatientApiController
  before_action :set_patient_profile, only: [:my_profile, :update_profile]

  def my_profile
    
  end

  def update_profile
    if @patient_profile.update(patient_profile_params)
      if (@patient_profile.name
        @patient_profile.genre &&
        @patient_profile.birth_date &&
        @patient_profile.height &&
        @patient_profile.bloodtype &&
        @patient_profile.telephone &&
        @patient_profile.weight)
        @patient_profile.complete = true
        @patient_profile.save
      end

      render :json => {
        success: true
      }
    else
      render :json => {
        success: false
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient_profile
      @patient_profile = current_patient.patient_profile
    end

    # Only allow a list of trusted parameters through.
    def patient_profile_params
      params.require(:patient_profile).permit(:genre, :birth_date, :height, :bloodtype, :weight)
    end
end
