class Patient < ApplicationRecord
    # Include default devise modules.
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, #:trackable
            :validatable,# authentication_keys: [:telephone]
            :confirmable, authentication_keys: [:cpf]
            #, :omniauthable
    include DeviseTokenAuth::Concerns::User    

    attr_accessor  :name
    attr_accessor  :genre
    attr_accessor  :birth_date
    attr_accessor  :height
    attr_accessor  :bloodtype
    attr_accessor  :telephone
    attr_accessor  :weight
    attr_accessor  :created_by_admin

    belongs_to :patient_profile, class_name: "PatientProfile", optional: true, foreign_key: "patient_profile_id"

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
            #self.confirmation_token = @raw_confirmation_token = Devise.friendly_token(6).upcase
            self.confirmation_token = @raw_confirmation_token = self.get_token
            self.confirmation_sent_at = Time.now.utc
        end
    end

    def get_token
        tok = ""        
        #Devise.friendly_token(6).upcase.chars.each do |c|
        #    tok += c.ord.to_s[0]
        #end
        6.times do |i|
            tok += (0..9).to_a.sample.to_s
        end
        tok
    end

    def unconfirmed_email        
    end

    def send_confirmation_instructions(args)
        send_confirmation_token()
    end

    def send_on_create_confirmation_instructions
    end

    def self.confirm_token params
        user = Patient.find_by(cpf: params[:cpf], confirmation_token: params[:confirmation_token])
        if user && !user.confirmed?
            if ((DateTime.now.to_time - user.confirmation_sent_at.to_time) / 1.hours < 8)
                user.confirmed_at = DateTime.now
                user.save
                return {:status => "success", :message => ""}
            else
                return {:status => "token_outdated", :message => "O token não é mais válido"}
            end
        else
            if user
                if user.confirmed?
                    return {:status => "error", :message => ""}
                end
            else
                return {:status => "invalid_token", :message => "O token não é válido"}
            end
        end        
    end

    def send_confirmation_token
        require 'twilio-ruby'

        account_sid = "AC3875fe61f107f15a2f5c6807ffc31feb" # Your Test Account SID from www.twilio.com/console/settings
        auth_token = "3eb4e67351007cbc9406fc3affbfe32a"   # Your Test Auth Token from www.twilio.com/console/settings

        @client = Twilio::REST::Client.new(account_sid, auth_token)
        message = @client.messages.create(
            body: "Insira o código #{self.confirmation_token} para confirmar a criação de sua conta",
            to: "+55#{self.telephone}",    # Replace with your phone number
            from: "+12512902370")  # Use this Magic Number for creating SMS
    end

    def complete_creation
        genres = ["m", "f"]
        bloodtypes = ["A+", "A-", "B+", "B-", "O+", "O-"]

        patient_profile = PatientProfile.create!(
            name: self.name,
            genre: self.genre,
            birth_date: self.birth_date,
            height: self.height,
            bloodtype: self.bloodtype,
            telephone: self.telephone,
            weight: self.weight,
            complete: false,
            patient: self
        )

        if !self.created_by_admin
            patient_address = Address.new
            patient_address.save
            patient_profile.save if patient_profile.address = patient_address
        end              
    
        patient_account = PatientAccount.create!(
            patient_profile: patient_profile
        )

        message_manager = MessageManager.create!(
            patient_profile: patient_profile,
            message_count: 0,
            active: false
        )
    end

    def self.check_cpf cpf
        if (patient = Patient.find_by(cpf: cpf))
            if patient.confirmed_at
                return {:control => "exists", :can_login => true}
            else
                return {:control => "exists", :can_login => false}
            end
        else
            return {:control => "not_exists", :can_login => false}
        end
    end
end