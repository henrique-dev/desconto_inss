class Admin::ClinicProfilesController < AdminController
  before_action :set_clinic_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /clinic_profiles
  # GET /clinic_profiles.json
  def index
    @clinic_profiles = ClinicProfile.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /clinic_profiles/1
  # GET /clinic_profiles/1.json
  def show
  end

  # GET /clinic_profiles/new
  def new
    @clinic_profile = ClinicProfile.new    
    @address = Address.new
    @clinic = Clinic.new
  end

  # GET /clinic_profiles/1/edit
  def edit
  end

  # POST /clinic_profiles
  # POST /clinic_profiles.json
  def create
    @clinic_profile = ClinicProfile.new(clinic_profile_params)
    @clinic = Clinic.new(clinic_params)
    @address = Address.new(address_params)
    if @clinic_profile.validate
      if @clinic.validate
        if @address.validate
          if @clinic.save && @address.save && @clinic_profile.save
            @clinic.save if @clinic.clinic_profile = @clinic_profile
            @clinic_profile.save if @clinic_profile.address = @address
            redirect_to @clinic_profile, notice: 'Clínica criado com sucesso.'
          end
        end
      else
        render :new
      end
    else
      render :new
    end
  end

  # PATCH/PUT /clinic_profiles/1
  # PATCH/PUT /clinic_profiles/1.json
  def update
    respond_to do |format|
      if @clinic_profile.update(clinic_profile_params) && @address.update(address_params) && @clinic.update(clinic_params)
        format.html { redirect_to @clinic_profile, notice: 'Clinic profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @clinic_profile }
      else
        format.html { render :edit }
        format.json { render json: @clinic_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinic_profiles/1
  # DELETE /clinic_profiles/1.json
  def destroy
    @clinic_profile.destroy
    respond_to do |format|
      format.html { redirect_to clinic_profiles_url, notice: 'Clinic profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic_profile
      @clinic_profile = ClinicProfile.find(params[:id])
      @clinic = @clinic_profile.clinic
      @address = @clinic_profile.address
    end

    # Only allow a list of trusted parameters through.
    def clinic_profile_params
      params.require(:clinic_profile).permit(:name, :cnpj, :description, :address_id, :photos => [])
    end

    def clinic_params
      params.require(:clinic).permit(:name, :cnpj)
    end

    def address_params
      params.require(:address).permit(:zipcode, :street, :street, :neighborhood, :city, :state, :country, :number)
    end
end
