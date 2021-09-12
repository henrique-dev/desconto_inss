class Patient::PatientAccountsController < PatientApiController
  before_action :set_patient_account, only: [:show, :edit, :update, :destroy]

  # GET /patient_accounts
  # GET /patient_accounts.json
  def index
    @patient_accounts = PatientAccount.all
  end

  # GET /patient_accounts/1
  # GET /patient_accounts/1.json
  def show
  end

  # GET /patient_accounts/new
  def new
    @patient_account = PatientAccount.new
  end

  # GET /patient_accounts/1/edit
  def edit
  end

  # POST /patient_accounts
  # POST /patient_accounts.json
  def create
    @patient_account = PatientAccount.new(patient_account_params)

    respond_to do |format|
      if @patient_account.save
        format.html { redirect_to @patient_account, notice: 'Patient account was successfully created.' }
        format.json { render :show, status: :created, location: @patient_account }
      else
        format.html { render :new }
        format.json { render json: @patient_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patient_accounts/1
  # PATCH/PUT /patient_accounts/1.json
  def update
    respond_to do |format|
      if @patient_account.update(patient_account_params)
        format.html { redirect_to @patient_account, notice: 'Patient account was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient_account }
      else
        format.html { render :edit }
        format.json { render json: @patient_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patient_accounts/1
  # DELETE /patient_accounts/1.json
  def destroy
    @patient_account.destroy
    respond_to do |format|
      format.html { redirect_to patient_accounts_url, notice: 'Patient account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient_account
      @patient_account = PatientAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_account_params
      params.require(:patient_account).permit(:patient_profile_id)
    end
end
