class Admin::AccountSpecialitiesController < ApplicationController
  before_action :set_account_speciality, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /account_specialities
  # GET /account_specialities.json
  def index
    @account_specialities = AccountSpeciality.all
  end

  # GET /account_specialities/1
  # GET /account_specialities/1.json
  def show
  end

  # GET /account_specialities/new
  def new
    @account_speciality = AccountSpeciality.new
  end

  # GET /account_specialities/1/edit
  def edit
  end

  # POST /account_specialities
  # POST /account_specialities.json
  def create
    @account_speciality = AccountSpeciality.new(account_speciality_params)

    respond_to do |format|
      if @account_speciality.save
        format.html { redirect_to @account_speciality, notice: 'Account speciality was successfully created.' }
        format.json { render :show, status: :created, location: @account_speciality }
      else
        format.html { render :new }
        format.json { render json: @account_speciality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_specialities/1
  # PATCH/PUT /account_specialities/1.json
  def update
    respond_to do |format|
      if @account_speciality.update(account_speciality_params)
        format.html { redirect_to @account_speciality, notice: 'Account speciality was successfully updated.' }
        format.json { render :show, status: :ok, location: @account_speciality }
      else
        format.html { render :edit }
        format.json { render json: @account_speciality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_specialities/1
  # DELETE /account_specialities/1.json
  def destroy
    @account_speciality.destroy
    respond_to do |format|
      format.html { redirect_to account_specialities_url, notice: 'Account speciality was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_speciality
      @account_speciality = AccountSpeciality.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_speciality_params
      params.require(:account_speciality).permit(:used_at, :used, :speciality_id, :patient_account_id, :medic_profile_id)
    end
end
