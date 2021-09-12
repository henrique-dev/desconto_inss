class Medic::MedicEvaluationsController < MedicApiController

  def index
    @medic_evaluations = current_medic.medic_profile.medic_evaluations
  end
  
end