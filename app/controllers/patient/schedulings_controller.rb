class Patient::SchedulingsController < PatientApiController
  before_action :set_scheduling, only: [:show, :edit, :update, :destroy]
  before_action :set_medic_work_scheduling, only: [:create]

  # GET /schedulings
  # GET /schedulings.json
  def index
    if params["consulted"]
      @schedulings = Scheduling.from_patient(current_patient.patient_profile_id).where(consulted: params["consulted"])
    else
      @schedulings = Scheduling.from_patient(current_patient.patient_profile_id)
    end
  end

  # GET /schedulings/1
  # GET /schedulings/1.json
  def show
  end

  # POST /schedulings
  # POST /schedulings.json
  def create
    target_date = @medic_work_scheduling.schedule_available? create_scheduling_params[:date_time]

    if target_date

      @scheduling = Scheduling.new_scheduling(target_date, @medic_work_scheduling, current_patient)

      if @scheduling
        
        @scheduling.speciality = @medic_work_scheduling.speciality

        if @scheduling.save        

          @medic_work_scheduling.save

          render :json => {
            success: true
          }
        else
          render :json => {
            success: false
          }
        end
      else
        render :json => {
          success: false
        }
      end
    else
      render :json => {
        success: false
      }
    end
  end

  # PATCH/PUT /schedulings/1
  # PATCH/PUT /schedulings/1.json
  def update
    respond_to do |format|
      if @scheduling.update(scheduling_params)
        format.html { redirect_to @scheduling, notice: 'Scheduling was successfully updated.' }
        format.json { render :show, status: :ok, location: @scheduling }
      else
        format.html { render :edit }
        format.json { render json: @scheduling.errors, status: :unprocessable_entity }
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
      @scheduling = Scheduling.from_patient(current_patient.patient_profile_id).find(params[:id])
    end

    def set_medic_work_scheduling
      @medic_work_scheduling = MedicWorkScheduling.find(params[:medic_work_scheduling_id])
    end

    # Only allow a list of trusted parameters through.
    def scheduling_params
      params.require(:scheduling).permit(:for_date, :consulted, :medic_work_scheduling_id, :patient_profile_id)
    end

    def create_scheduling_params
      params.permit(:id, :date_time)
    end

end
