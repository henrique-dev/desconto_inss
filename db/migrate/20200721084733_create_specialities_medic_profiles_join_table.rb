class CreateSpecialitiesMedicProfilesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :medic_profiles_specialities, :id => false do |t|
      t.integer :speciality_id
      t.integer :medic_profile_id
    end
  
    add_index :medic_profiles_specialities, [:speciality_id, :medic_profile_id], :name => "sp_md_index"
  end
end
