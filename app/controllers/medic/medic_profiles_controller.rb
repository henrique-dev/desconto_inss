class Medic::MedicProfilesController < MedicApiController
  before_action :set_medic_profile, only: [:my_profile, :update_profile, :update_profile_file]

  def my_profile
    
  end

  def update_profile
    if @medic_profile.update(medic_profile_params)
      if (@medic_profile.name
        @medic_profile.genre &&
        @medic_profile.birth_date &&
        @medic_profile.height &&
        @medic_profile.bloodtype &&
        @medic_profile.telephone &&
        @medic_profile.weight)
        @medic_profile.complete = true
        @medic_profile.save
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

  def update_profile_file
    render :json => {
      success: @medic_profile.update(medic_profile_file_params)
    }
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_medic_profile
    @medic_profile = current_medic.medic_profile
  end

  # Only allow a list of trusted parameters through.
  def medic_profile_params
    params.require(:medic_profile).permit(:genre, :birth_date, :height, :bloodtype, :weight)
  end

  def medic_profile_file_params
    params.permit(:photo)
  end
end
