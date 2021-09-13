class Admin::UsersController < AdminController
  before_action :set_user, only: %i[ show edit update destroy ]

  def calculate_deduction
    render :json => {:deduction => User.calculate_deduction(params[:wage])}
  end

  # GET /users or /users.json
  def index
    @users = User.page(params[:page])
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @user.address = Address.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @address = Address.new(user_params["address_attributes"])
    respond_to do |format|
      if @user.save && @address.save
        #@address.user_id = @user.id
        
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        @address.update(address_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      @address = @user.address
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :cpf, :birth_date, :wage, :telephone_1, :telephone_2, address_attributes: [:street, :number, :neighborhood, :city, :state, :zipcode])
      #:street, :number, :neighborhood, :city, :state, :zipcode)
    end

    def address_params
      params.require(:user).permit(:address_attributes)
    end
end
