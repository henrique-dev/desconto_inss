class Admin::PatientProfilesController < AdminController
  before_action :set_patient_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /patient_profiles
  # GET /patient_profiles.json
  def index
    @patient_profiles = PatientProfile.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /patient_profiles/1
  # GET /patient_profiles/1.json
  def show
  end

  # GET /patient_profiles/new
  def new
    @patient_profile = PatientProfile.new    
    @address = Address.new
    @patient = Patient.new
  end

  # GET /patient_profiles/1/edit
  def edit    
  end

  # POST /patient_profiles
  # POST /patient_profiles.json
  def create
    @patient_profile = PatientProfile.new(patient_profile_params)
    @patient = Patient.new(patient_profile_params.merge({:provider => "email" ,:email => patient_profile_params[:uid]}))
    @address = Address.new(address_params)
    if @patient_profile.validate
      if @patient.validate
        if @address.validate
          if @patient.save && @address.save
            @patient_profile = @patient.patient_profile
            @patient_profile.save if @patient_profile.address = @address            
            redirect_to @patient_profile, notice: 'Paciente criado com sucesso.'
          end
        end
      else
        render :new
      end
    else
      render :new
    end
  end

  # PATCH/PUT /patient_profiles/1
  # PATCH/PUT /patient_profiles/1.json
  def update
    respond_to do |format|
      if @patient_profile.update(patient_profile_params) && @address.update(address_params)
        format.html { redirect_to @patient_profile, notice: 'Patient profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient_profile }
      else
        format.html { render :edit }
        format.json { render json: @patient_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patient_profiles/1
  # DELETE /patient_profiles/1.json
  def destroy
    @patient_profile.destroy
    respond_to do |format|
      format.html { redirect_to patient_profiles_url, notice: 'Patient profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient_profile
      @patient_profile = PatientProfile.find(params[:id])
      @patient = @patient_profile.patient
      @address = @patient_profile.address
    end

    # Only allow a list of trusted parameters through.
    def patient_profile_params
      hash = params.require(:patient_profile).permit(:cpf, :password, :password_confirmation, :uid, :email, 
        :name, :genre, :birth_date, :height, :bloodtype, :telephone, :weight, :created_by_admin)
      if hash[:cpf]
        hash[:cpf] = hash[:cpf].gsub(".", "")
        hash[:cpf] = hash[:cpf].gsub("-", "")
      end
      hash
    end

    def address_params
      params.require(:address).permit(:zipcode, :street, :street, :neighborhood, :city, :state, :country)
    end

end
