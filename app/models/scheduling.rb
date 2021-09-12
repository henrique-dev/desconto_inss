class Scheduling < ApplicationRecord
  has_many :medic_evaluations, dependent: :destroy
  
  belongs_to :medic_work_scheduling
  belongs_to :patient_profile
  belongs_to :medic_profile
  belongs_to :speciality

  attr_accessor :speciality_forwarding

  scope :from_patient,                   lambda {|id| where(patient_profile_id: id)}
  scope :from_medic,                     lambda {|id| where(medic_profile_id: id)}
  scope :from_medic_work_scheduling,     lambda {|id| where(medic_work_scheduling_id: id)}
  scope :consulted,                      lambda {|co| where(consulted: co)}

  def self.new_scheduling target_date, medic_work_scheduling, patient

    patient_profile = patient.patient_profile
    patient_account = patient_profile.patient_account
    speciality = medic_work_scheduling.speciality

    if speciality.priv

      if account_speciality = patient_account.account_specialities.find_by(speciality_id: speciality.id)
        account_speciality.destroy
        scheduling = Scheduling.new({
          :for_date => target_date,
          :for_time => target_date,
          :consulted => false,
          :medic_work_scheduling => medic_work_scheduling,
          :medic_profile => medic_work_scheduling.medic_profile,
          :patient_profile => patient.patient_profile
        })
      else
        return nil
      end 
    else
      scheduling = Scheduling.new({
        :for_date => target_date,
        :for_time => target_date,
        :consulted => false,
        :medic_work_scheduling => medic_work_scheduling,
        :medic_profile => medic_work_scheduling.medic_profile,
        :patient_profile => patient.patient_profile
      })
    end

  end
  
end
