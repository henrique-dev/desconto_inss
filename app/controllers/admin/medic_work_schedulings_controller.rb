class Admin::MedicWorkSchedulingsController < AdminController
  before_action :set_medic_work_scheduling, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /medic_work_schedulings
  # GET /medic_work_schedulings.json
  def index
    @medic_work_schedulings = MedicWorkScheduling.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /medic_work_schedulings/1
  # GET /medic_work_schedulings/1.json
  def show
  end

  # GET /medic_work_schedulings/new
  def new
    @medic_work_scheduling = MedicWorkScheduling.new
    @medic_work_scheduling.days_of_week = "0111110"
  end

  # GET /medic_work_schedulings/1/edit
  def edit
  end

  # POST /medic_work_schedulings
  # POST /medic_work_schedulings.json
  def create
    @medic_work_scheduling = MedicWorkScheduling.new(medic_work_scheduling_params)
    @medic_work_scheduling.counter_of_day = 0
    @medic_work_scheduling.last = nil

    respond_to do |format|
      if @medic_work_scheduling.save

        medic_profile = @medic_work_scheduling.medic_profile
        speciality = @medic_work_scheduling.speciality
        medic_profile.save if medic_profile.specialities << speciality

        format.html { redirect_to @medic_work_scheduling, notice: 'Medic work scheduling was successfully created.' }
        format.json { render :show, status: :created, location: @medic_work_scheduling }
      else
        format.html { render :new }
        format.json { render json: @medic_work_scheduling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medic_work_schedulings/1
  # PATCH/PUT /medic_work_schedulings/1.json
  def update
    respond_to do |format|
      if @medic_work_scheduling.update(medic_work_scheduling_params)
        format.html { redirect_to @medic_work_scheduling, notice: 'Medic work scheduling was successfully updated.' }
        format.json { render :show, status: :ok, location: @medic_work_scheduling }
      else
        format.html { render :edit }
        format.json { render json: @medic_work_scheduling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medic_work_schedulings/1
  # DELETE /medic_work_schedulings/1.json
  def destroy
    @medic_work_scheduling.destroy
    respond_to do |format|
      format.html { redirect_to medic_work_schedulings_url, notice: 'Medic work scheduling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medic_work_scheduling
      @medic_work_scheduling = MedicWorkScheduling.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def medic_work_scheduling_params
      params.require(:medic_work_scheduling).permit(:last, :counter_of_day, :info, :days_of_week, :clinic_profile_id, :speciality_id, :medic_profile_id, :complement)
    end
end
