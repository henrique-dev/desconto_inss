class Medic::MedicWorkSchedulingsController < MedicApiController
  before_action :set_medic_work_scheduling, only: [:check_scheduling_priv]

  def index
    @medic_work_schedulings = MedicWorkScheduling.from_medic(current_medic.medic_profile.id)
  end
    
end
