class Medic < ApplicationRecord
    # Include default devise modules.
    devise :database_authenticatable, :registerable,
                :recoverable, :rememberable, #:trackable
                :validatable,# authentication_keys: [:telephone]
                :confirmable, authentication_keys: [:cpf]
            #:confirmable, :omniauthable
    include DeviseTokenAuth::Concerns::User    

    attr_accessor  :name
    attr_accessor  :genre
    attr_accessor  :birth_date
    attr_accessor  :height
    attr_accessor  :bloodtype
    attr_accessor  :telephone
    attr_accessor  :weight

    belongs_to :medic_profile, class_name: "MedicProfile", optional: true, foreign_key: "medic_profile_id"

    validates :cpf, presence: true, uniqueness: { case_sensitive: false }

    after_create :complete_creation
  
    def email_required?    
        false
    end

    def email_changed? 
        false 
    end 

    def generate_confirmation_token
        if self.confirmation_token && !confirmation_period_expired?
            @raw_confirmation_token = self.confirmation_token
        else
            self.confirmation_token = @raw_confirmation_token = Devise.friendly_token(6).upcase
            self.confirmation_sent_at = Time.now.utc
        end
    end

    def unconfirmed_email        
    end

    def send_confirmation_instructions(args)
    end

    def send_on_create_confirmation_instructions
    end

    def self.confirm_token params
        user = Medic.find_by(cpf: params[:cpf], confirmation_token: params[:confirmation_token])
        if user && !user.confirmed?
            if ((DateTime.now.to_time - user.confirmation_sent_at.to_time) / 1.hours < 8)
                user.confirmed_at = DateTime.now
                user.save
                return {:status => "success", :message => ""}
            else
                return {:status => "token_outdated", :message => "O token não é mais válido"}
            end
        else
            if user.confirmed?
                return {:status => "success", :message => ""}
            end
        end        
    end

    def send_confirmation_token
        require 'twilio-ruby'

        account_sid = "AC3d4416535a462a996a081251985f1094" # Your Test Account SID from www.twilio.com/console/settings
        auth_token = "05fa8c5e7f6df0166287430633645864"   # Your Test Auth Token from www.twilio.com/console/settings

        @client = Twilio::REST::Client.new account_sid, auth_token
        message = @client.messages.create(
            body: "Insira o código #{self.confirmation_token} para confirmar a criação de sua conta",
            to: "+5596991100443",    # Replace with your phone number
            from: "+12084178988")  # Use this Magic Number for creating SMS
    end

    def complete_creation
        genres = ["m", "f"]
        bloodtypes = ["A+", "A-", "B+", "B-", "O+", "O-"]

        medic_profile = MedicProfile.create!(
            name: self.name,
            genre: self.genre,
            birth_date: self.birth_date,
            height: self.height,
            bloodtype: self.bloodtype,
            telephone: self.telephone,
            weight: self.weight,
            medic: self,
            experience: "0",
            rating: 5,
            rating_qtd: 0,
            complete: false
        )

        message_manager = MessageManager.create!(
            medic_profile: medic_profile,
            message_count: 0,
            active: false
        )

        self.provider = "cpf"
        self.uid = self.cpf
        self.confirmed_at = DateTime.now
        self.save
    end

    def self.check_cpf cpf
        if (Medic.find_by(cpf: cpf))
            return {:control => "exists", :can_login => true}
        else
            return {:control => "not_exists", :can_login => false}
        end
    end
end