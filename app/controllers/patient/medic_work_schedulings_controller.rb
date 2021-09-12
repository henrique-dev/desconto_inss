class Patient::MedicWorkSchedulingsController < PatientApiController
  before_action :set_medic_work_scheduling, only: [:get_unavailable_days, :get_schedules_on_day, :confirm_schedule_on_day, :check_scheduling_priv]
  #before_action :authenticate_patient!

  def check_scheduling_priv
    data = @medic_work_scheduling.check_scheduling_priv(current_patient.patient_profile.patient_account)
    render :json => {
      :success => data[:success],
      #:success => true,
      :message => data[:message],
      :id => @medic_work_scheduling.id
    }
  end

  def get_unavailable_days
    unavailable_days = @medic_work_scheduling.get_unavailable_days(current_patient)
    render :json => {
      :success => true,
      :current_date_time => (DateTime.now+1).strftime("%Y-%m-%d"),
      :medic_work_scheduling => @medic_work_scheduling,
      :medic_profile => @medic_work_scheduling.medic_profile,
      :speciality => @medic_work_scheduling.speciality,
      :clinic_profile => @medic_work_scheduling.clinic_profile,
      :clinic => @medic_work_scheduling.clinic_profile.clinic,
      :unavailable_days => unavailable_days
    }
  end

  def get_schedules_on_day
    schedules = @medic_work_scheduling.get_schedules_on_day(params["date"])
    render :json => {
      :success => true,
      :schedules => schedules
    }
  end

  def confirm_schedule_on_day
    schedules = @medic_work_scheduling.get_schedules_on_day(params["time"])
    render :json => {
      :success => true
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medic_work_scheduling
      @medic_work_scheduling = MedicWorkScheduling.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def medic_work_scheduling_params
      params.require(:medic_work_scheduling).permit(:perDay, :last, :counter_of_day, :info, :days_of_week, :clinic_profile_id, :speciality_id, :complement)
    end    
end
