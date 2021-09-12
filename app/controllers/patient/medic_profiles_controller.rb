class Patient::MedicProfilesController < PatientApiController
  before_action :set_medic_profile, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_patient!

  # GET /medic_profiles
  # GET /medic_profiles.json
  def index
    @medic_profiles = []
    if params["speciality"]
      if params["speciality"].to_i > -1
        @speciality = Speciality.where(id: params["speciality"]).first
        if @speciality
          @speciality.medic_work_schedulings.each do |medic_work_scheduling|
            medic_profile = medic_work_scheduling.medic_profile
            medic_profile.medic_work_scheduling = medic_work_scheduling
            @medic_profiles << medic_profile
          end
        end
      elsif params["speciality"].to_i == -1
        MedicWorkScheduling.search(params["search"]).each do |mws|
          medic_profile = mws.medic_profile
          medic_profile.medic_work_scheduling = mws
          @medic_profiles << medic_profile
        end        
      end
    else
      @medic_profiles = MedicProfile.all
    end
  end

  # GET /medic_profiles/1
  # GET /medic_profiles/1.json
  def show
  end

  # GET /medic_profiles/new
  def new
    @medic_profile = MedicProfile.new
  end

  # GET /medic_profiles/1/edit
  def edit
  end

  # POST /medic_profiles
  # POST /medic_profiles.json
  def create
    @medic_profile = MedicProfile.new(medic_profile_params)

    respond_to do |format|
      if @medic_profile.save
        format.html { redirect_to @medic_profile, notice: 'Medic profile was successfully created.' }
        format.json { render :show, status: :created, location: @medic_profile }
      else
        format.html { render :new }
        format.json { render json: @medic_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medic_profiles/1
  # PATCH/PUT /medic_profiles/1.json
  def update
    respond_to do |format|
      if @medic_profile.update(medic_profile_params)
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
    end

    # Only allow a list of trusted parameters through.
    def medic_profile_params
      params.require(:medic_profile).permit(:name, :genre, :birth_date, :height, :bloodtype, :telephone, :weight)
    end
end
