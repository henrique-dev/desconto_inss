class Patient::MedicEvaluationsController < PatientApiController
  before_action :set_medic_evaluation, only: [:show]

  def index
    @medic_evaluations = current_patient.patient_profile.medic_evaluations
  end

  def show
  end

  def create
    @medic_evaluation = MedicEvaluation.new(medic_evaluation_params)
    if (@scheduling = current_patient.patient_profile.schedulings.find(medic_evaluation_params[:scheduling_id]))
      @medic_evaluation.patient_profile_id = @scheduling.patient_profile_id
      @medic_evaluation.medic_profile_id = @scheduling.medic_profile_id
      @scheduling.rated = true
      @scheduling.save

      if (@medic_evaluation.save)
        @medic_profile = @scheduling.medic_profile
        @medic_profile.rating_qtd += 1
        total = @medic_profile.medic_evaluations.sum(:rating)
        @medic_profile.rating = total / @medic_profile.rating_qtd
        @medic_profile.save

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
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_medic_evaluation
    @patient_file = PatientFile.from_patient_account(current_patient.patient_profile.patient_account.id).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def medic_evaluation_params
    params.permit(:description, :rating, :scheduling_id)
  end
end