class Patient::PatientFilesController < PatientApiController
  before_action :set_patient_file, only: [:show, :edit, :update]

  def index
    @patient_files = PatientFile.from_patient_account(current_patient.patient_profile.patient_account.id)
  end

  def show
  end

  def create
    @patient_file = PatientFile.new(patient_file_params)    
    @patient_file.patient_account_id = current_patient.patient_profile.patient_account.id
    render :json => {
      success: @patient_file.save
    }
  end

  def update
    respond_to do |format|
      if @patient_file.update(patient_file_params)
        format.json { render :show, status: :ok, location: @patient_file }
      else
        format.json { render json: @patient_file.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_profile_file
    @patient_profile = current_patient.patient_profile
    render :json => {
      success: @patient_profile.update(patient_profile_file_params)
    }
  end
  
  def destroy
    @patient_file.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_patient_file
    @patient_file = PatientFile.from_patient_account(current_patient.patient_profile.patient_account.id).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def patient_file_params
    params.permit(:description, :category, :photo)
  end

  def patient_profile_file_params
    params.permit(:photo)
  end
end