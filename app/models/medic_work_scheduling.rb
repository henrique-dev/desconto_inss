class MedicWorkScheduling < ApplicationRecord
  belongs_to :clinic_profile
  belongs_to :speciality
  belongs_to :medic_profile
  has_many :schedulings, dependent: :destroy

  scope :from_medic,       lambda {|id| where(medic_profile_id: id)}
  scope :search,           lambda {|filter| where("medic_name like ? or clinic_name like ? or speciality_name like ?", "%#{filter}%", "%#{filter}%", "%#{filter}%")}

  after_create :complete_creation

  def check_scheduling_priv patient_account
    patient = patient_account.patient_profile
    if self.days_of_week.to_i == 0
      return {:success => false, :message => "Não é possível agendar com este especialista no momento"}
    end
    if self.speciality.priv
      if patient_account.account_specialities.find_by(speciality_id: self.speciality.id)
        if Scheduling.find_by(patient_profile_id: patient.id, speciality_id: self.speciality.id, consulted: false)
          return {:success => false, :message => "Já existe uma consulta agendada com este tipo de especialista"}
        end
        return {:success => true, :message => ""}
      else
        return {:success => false, :message => "É necessário um encaminhamento específico para fazer este agendamento"}
      end
    else
      if Scheduling.find_by(patient_profile_id: patient.id, speciality_id: self.speciality.id, consulted: false)
        return {:success => false, :message => "Já existe uma consulta agendada com este tipo de especialista"}
      end
      return {:success => true, :message => ""}
    end
  end

  def get_unavailable_days patient
    unavailable_dates = []
    schedulings = self.schedulings.group(:for_date).count

    schedulings.keys.each do |date|
      schedules = get_schedules_on_day(date.to_s)
      if (schedules.count == 0)
        unavailable_dates << date.strftime("%Y-%m-%d")
      end
    end
    unavailable_dates
  end

  def get_schedules_on_day date_string
    date = DateTime.parse(date_string)
    schedulings = self.schedulings.where(consulted: false, for_date: date.strftime("%Y-%m-%d"))

    time_start_at = Time.new(date.year, date.month, date.day, self.start_at.hour, self.start_at.min) - 2.hour
    time_end_at = Time.new(date.year, date.month, date.day, self.end_at.hour, self.end_at.min) - 2.hour

    time_interval_start_at = Time.new(date.year, date.month, date.day, self.interval_start_at.hour, self.interval_start_at.min) - 2.hour
    time_interval_end_at = Time.new(date.year, date.month, date.day, self.interval_end_at.hour, self.interval_end_at.min) - 2.hour

    schedules = []

    while (time_start_at < time_end_at)
      if (!(time_start_at >= time_interval_start_at && time_start_at <= time_interval_end_at))
        if (!schedulings.find_by(for_time: time_start_at.strftime("%H:%M")))
          schedules << time_start_at.strftime("%Y-%m-%d %H:%M")
        end
      end      
      time_start_at += self.duration.minutes
    end
    schedules
  end

  def schedule_available? date_time_string
    date_time = DateTime.parse(date_time_string)
    schedulings = self.schedulings.where(consulted: false, for_date: date_time.strftime("%Y-%m-%d"))
    if (schedulings.find_by(for_time: date_time.strftime("%H:%M")))
      return nil
    else
      return date_time
    end
  end

  def update_scheduling_count target_date
    self.counter_of_day = self.counter_of_day + 1
    if self.counter_of_day >= self.per_day
      self.last = target_date + 1
      self.counter_of_day = 0
    else
      self.last = target_date
    end    
    true
  end

  def complete_creation
    self.start_at = Time.new(Time.now.year, Time.now.month, Time.now.day, 8, 0, 0)
    self.end_at = Time.new(Time.now.year, Time.now.month, Time.now.day, 10, 0, 0)
    self.interval_start_at = Time.new(Time.now.year, Time.now.month, Time.now.day, 12, 0, 0)
    self.interval_end_at = Time.new(Time.now.year, Time.now.month, Time.now.day, 14, 0, 0)
    self.duration = 15
    self.save
  end

end
