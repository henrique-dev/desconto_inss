class Admin::SchedulingsController < AdminController
  before_action :set_scheduling, only: [:edit, :update]
  before_action :set_specialities, only: [:edit, :update]
  before_action :authenticate_admin!

  def medics
    @schedulings = Scheduling.all
  end

  # GET /schedulings
  # GET /schedulings.json
  def index
    @schedulings = Scheduling.where(consulted: false).all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /schedulings/1
  # GET /schedulings/1.json
  #def show
  #end

  # GET /schedulings/new
  #def new
  #  @scheduling = Scheduling.new
  #end

  # GET /schedulings/1/edit
  def edit
  end

  # POST /schedulings
  # POST /schedulings.json
  #def create
  #  @scheduling = Scheduling.new(scheduling_params)

  #  respond_to do |format|
  #    if @scheduling.save
  #      format.html { redirect_to @scheduling, notice: 'Scheduling was successfully created.' }
  #      format.json { render :show, status: :created, location: @scheduling }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @scheduling.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PATCH/PUT /schedulings/1
  # PATCH/PUT /schedulings/1.json
  def update

    @scheduling.consulted = true
    @scheduling.consulted_at = DateTime.now

    if (scheduling_params[:speciality_forwarding] && Speciality.find_by(id: scheduling_params[:speciality_forwarding].to_i))

      if !AccountSpeciality.find_by(speciality_id: scheduling_params[:speciality_forwarding], patient_account_id: @patient_profile.patient_account.id)
        as = AccountSpeciality.new
        as.used = false
        as.speciality_id = scheduling_params[:speciality_forwarding].to_i
        as.patient_account = @patient_profile.patient_account
        as.medic_profile = @scheduling.medic_work_scheduling.medic_profile
        if as.save
          if @scheduling.save
            redirect_to schedulings_url, notice: 'Consulta finalizada.'
          else
            render :edit
          end
        else
          render :edit
        end
      else
        render :edit
      end
    else
      if @scheduling.save
        redirect_to schedulings_url, notice: 'Consulta finalizada.'
      else
        render :edit
      end
    end        
  end

  # DELETE /schedulings/1
  # DELETE /schedulings/1.json
  def destroy
    @scheduling.destroy
    respond_to do |format|
      format.html { redirect_to schedulings_url, notice: 'Scheduling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scheduling
      @scheduling = Scheduling.find(params[:id])
      @patient_profile = @scheduling.patient_profile
    end

    def set_specialities
      @specialities = Speciality.where(priv: true)
    end

    # Only allow a list of trusted parameters through.
    def scheduling_params
      params.require(:scheduling).permit(:speciality_forwarding)
    end
end
