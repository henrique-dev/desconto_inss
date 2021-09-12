class Medic::RegisterController < ApplicationController
  
  def check_telephone
    render json: {:status => Medic.check_cpf(register_params[:cpf])}
  end

  def check_token
    user = Medic.find_by(cpf: register_params[:uid])

    if user && user.valid_token?(register_params[:access_token], register_params[:client])
      render json: {:success => true}
    else
      render json: {:success => false}
    end    
  end

  def confirm_token
    render json: Medic.confirm_token(register_params)
  end

  private    

  # Only allow a list of trusted parameters through.
  def register_params
    params.require(:register).permit(:id, :uid, :access_token, :client, :cpf, :confirmation_token)
  end
end
