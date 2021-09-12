class AddClinicProfileToClinics < ActiveRecord::Migration[5.2]
  def change
    add_reference :clinics, :clinic_profile, foreign_key: true
  end
end
