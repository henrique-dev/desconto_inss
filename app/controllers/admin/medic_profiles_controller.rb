class Admin::MedicProfilesController < AdminController
  before_action :set_medic_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /medic_profiles
  # GET /medic_profiles.json
  def index
    @medic_profiles = MedicProfile.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /medic_profiles/1
  # GET /medic_profiles/1.json
  def show
  end

  # GET /medic_profiles/new
  def new
    @medic_profile = MedicProfile.new    
    @address = Address.new
    @medic = Medic.new
  end

  # GET /medic_profiles/1/edit
  def edit
  end

  # POST /medic_profiles
  # POST /medic_profiles.json
  def create
    @medic_profile = MedicProfile.new(medic_profile_params)
    @medic = Medic.new(medic_profile_params.merge({:provider => "email" ,:email => medic_profile_params[:uid]}))
    @address = Address.new(address_params)
    if @medic_profile.validate
      if @medic.validate
        if @address.validate
          if @medic.save && @address.save
            @medic_profile = @medic.medic_profile
            @medic_profile.save if @medic_profile.address = @address
            redirect_to @medic_profile, notice: 'Médico criado com sucesso.'
          end
        end
      else
        render :new
      end
    else
      render :new
    end
  end

  # PATCH/PUT /medic_profiles/1
  # PATCH/PUT /medic_profiles/1.json
  def update
    respond_to do |format|
      if @medic_profile.update(medic_profile_params) && @address.update(address_params)
        format.html { redirect_to @medic_profile, notice: 'Medic profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @medic_profile }
      else
        format.html { render :edit }
        format.json { render json: @medic_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medic_profiles/1
  # DELETE /medic_profiles/1.json
  def destroy
    @medic_profile.destroy
    respond_to do |format|
      format.html { redirect_to medic_profiles_url, notice: 'Medic profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medic_profile
      @medic_profile = MedicProfile.find(params[:id])
      @medic = @medic_profile.medic
      @address = @medic_profile.address
    end

    # Only allow a list of trusted parameters through.
    def medic_profile_params
      hash = params.require(:medic_profile).permit(:cpf, :password, :confirm_password, :uid, :email, 
        :name, :genre, :birth_date, :height, :bloodtype, :telephone, :weight)
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
