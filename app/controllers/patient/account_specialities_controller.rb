class Patient::AccountSpecialitiesController < PatientApiController
  before_action :set_account_speciality, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_patient!

  # GET /account_specialities
  # GET /account_specialities.json
  def index
    @account_specialities = AccountSpeciality.from_patient_account(current_patient.patient_profile.patient_account)
  end

  # GET /account_specialities/1
  # GET /account_specialities/1.json
  def show
  end

  # POST /account_specialities
  # POST /account_specialities.json
  def create
    @account_speciality = AccountSpeciality.new(account_speciality_params)

    respond_to do |format|
      if @account_speciality.save
        format.html { redirect_to @account_speciality, notice: 'Account speciality was successfully created.' }
        format.json { render :show, status: :created, location: @account_speciality }
      else
        format.html { render :new }
        format.json { render json: @account_speciality.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_speciality
      @account_speciality = AccountSpeciality.from_patient_account(current_patient.patient_profile.patient_account).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_speciality_params
      params.require(:account_speciality).permit(:used_at, :used, :speciality_id, :patient_account_id, :medic_profile_id)
    end
end
