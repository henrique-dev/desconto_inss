class Medic::SchedulingsController < MedicApiController
  before_action :set_scheduling, only: [:show, :finalize, :patient_profile, :patient_files]

  def index
    if params["consulted"]
      @schedulings = Scheduling.from_medic(current_medic.medic_profile).from_medic_work_scheduling(params[:medic_work_scheduling]).consulted(params["consulted"])
    else
      @schedulings = Scheduling.from_medic(current_medic.medic_profile).from_medic_work_scheduling(params[:medic_work_scheduling])
    end    
  end

  def edit
  end

  def days
    @schedulings = Scheduling.from_medic(current_medic.medic_profile).
      from_medic_work_scheduling(params[:medic_work_scheduling]).consulted(false).order(:for_date).group(:for_date).count
    render json: {:success => true, :schedulings => @schedulings}
  end

  def day
    @schedulings = Scheduling.from_medic(current_medic.medic_profile).
      from_medic_work_scheduling(params[:medic_work_scheduling]).consulted(false).where(for_date: params[:date]).order(:for_time)
  end

  def patient_profile
    @patient_profile = @scheduling.patient_profile
    photo_url = nil
    if @patient_profile.photo.attached? && photo = @patient_profile.photo
        photo_url = rails_blob_path(photo, disposition: "attachment", only_path: true)
    end
    render json: {:success => true, :patient_profile => @scheduling.patient_profile, :photo => photo_url}
  end

  def patient_files
    @patient_files = []
    @scheduling.patient_profile.patient_account.patient_files.each do |patient_file|
      @patient_files << {
        :id => patient_file.id,
        :description => patient_file.description,
        :category => patient_file.category,
        :created_at => patient_file.created_at,
        :url => rails_blob_path(patient_file.photo, disposition: "attachment", only_path: true)
      }
    end
    render json: {:success => true, :patient_files => @patient_files}
  end

  def finalize

    @scheduling.rated = false
    @scheduling.consulted = true
    @scheduling.consulted_at = DateTime.now

    if (scheduling_params[:specialities_forwarding] && Speciality.find_by(id: scheduling_params[:specialities_forwarding].to_i))
      if Speciality.find_by(id: scheduling_params[:specialities_forwarding])
        if !AccountSpeciality.find_by(speciality_id: scheduling_params[:specialities_forwarding], patient_account_id: @patient_profile.patient_account.id)
          as = AccountSpeciality.new
          as.used = false
          as.speciality_id = scheduling_params[:specialities_forwarding].to_i
          as.patient_account = @patient_profile.patient_account
          as.medic_profile = @scheduling.medic_work_scheduling.medic_profile
          as.save
        end
      end
    end

    if @scheduling.save
      render json: {:success => true}
    else
      render json: {:success => false}
    end

  end

  def destroy
    @scheduling.destroy
    respond_to do |format|
      format.html { redirect_to schedulings_url, notice: 'Scheduling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private    
    def set_scheduling
      @scheduling = Scheduling.from_medic(current_medic.medic_profile).find(params[:id])
      @patient_profile = @scheduling.patient_profile
      @specialities = Speciality.where(priv: true).to_a
      @specialities << Speciality.new({:id => -1, :name => "Nenhum"})
      @specialities = @specialities.reverse
    end

    def set_specialities
      @specialities = Speciality.where(priv: true)
    end

    def scheduling_params
      #params.require(:scheduling).permit(:id, :specialities_forwarding => {})
      params.require(:scheduling).permit(:id, :specialities_forwarding)
    end

end
