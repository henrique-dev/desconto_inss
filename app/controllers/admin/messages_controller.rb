class Admin::MessagesController < AdminController
  before_action :set_clinic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  def index
    # @message_managers = MessageManager.where(active: true)
  end

  def show
  end

  def new
    @clinic = Clinic.new
  end

  def edit
  end

  def create
    @clinic = Clinic.new(clinic_params)

    respond_to do |format|
      if @clinic.save
        format.html { redirect_to @clinic, notice: 'Clinic was successfully created.' }
        format.json { render :show, status: :created, location: @clinic }
      else
        format.html { render :new }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @clinic.update(clinic_params)
        format.html { redirect_to @clinic, notice: 'Clinic was successfully updated.' }
        format.json { render :show, status: :ok, location: @clinic }
      else
        format.html { render :edit }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @clinic.destroy
    respond_to do |format|
      format.html { redirect_to clinics_url, notice: 'Clinic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_clinic
    @clinic = Clinic.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def clinic_params
    params.require(:clinic).permit(:name, :cnpj)
  end
end
