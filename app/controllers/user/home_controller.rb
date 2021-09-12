class User::HomeController < UserController
  def index
    @patients_count = Patient.count
    @medics_count = Medic.count
    @clinics_count = Clinic.count
  end
end
