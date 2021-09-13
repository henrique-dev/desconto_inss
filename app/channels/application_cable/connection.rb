module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_patient, :current_medic, :current_admin

    def connect
      if cookies.signed[:admin_id]
        self.current_admin = find_verified_admin(cookies.signed[:admin_id])
        logger.add_tags 'ActionCable', current_admin.id
      elsif request.headers['src']
        access_token = request.headers['access-token']
        uid = request.headers['uid']
        client = request.headers['client']
        if request.headers['src'] == 'patient'
          self.current_patient = find_verified_patient(access_token, uid, client)
          logger.add_tags 'ActionCable', current_patient.cpf
        elsif request.headers['src'] == 'medic'
          self.current_medic = find_verified_medic(access_token, uid, client)
          logger.add_tags 'ActionCable', current_medic.cpf
        end
      end
    end

    private

    def find_verified_admin(admin_id)
      if user = Admin.find_by(id: admin_id)
        user
      else
        reject_unauthorized_connection
      end
    end
  end
end
