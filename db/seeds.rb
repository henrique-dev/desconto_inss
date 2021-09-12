# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
DEFAULT_PASSWORD_ADMIN = 'ZXDas7966mby@'
DEFAULT_PASSWORD_USER = '123456'
GENRES = ["m", "f"]
BLOODTYPE = ["A+", "A-", "B+", "B-", "O+", "O-"]
SPECIALITIES = [
    {:d => "Cardiologista", :v => true}, 
    {:d => "Psiquiatra", :v => true}, 
    {:d => "Fisioterapeuta", :v => true}, 
    {:d => "Pediatra", :v => true}, 
    {:d => "Dermatologista", :v => true}, 
    {:d => "Neurologista", :v => true}, 
    {:d => "Clinico Geral", :v => false}]

Admin.create!(email: 'admin1@dss.com', password: DEFAULT_PASSWORD_ADMIN, password_confirmation: DEFAULT_PASSWORD_ADMIN)
Admin.create!(email: 'admin2@dss.com', password: DEFAULT_PASSWORD_ADMIN, password_confirmation: DEFAULT_PASSWORD_ADMIN)
Admin.create!(email: 'admin3@dss.com', password: DEFAULT_PASSWORD_ADMIN, password_confirmation: DEFAULT_PASSWORD_ADMIN)

User.create!(email: 'admin4@dss.com', password: DEFAULT_PASSWORD_ADMIN, password_confirmation: DEFAULT_PASSWORD_ADMIN)
User.create!(email: 'admin5@dss.com', password: DEFAULT_PASSWORD_ADMIN, password_confirmation: DEFAULT_PASSWORD_ADMIN)
User.create!(email: 'admin6@dss.com', password: DEFAULT_PASSWORD_ADMIN, password_confirmation: DEFAULT_PASSWORD_ADMIN)

10.times do |i|
    clinic = Clinic.create!(
        name: "Clinic #{Faker::Name.name}",
        cnpj: Faker::Number.leading_zero_number(digits: 15)
    )    

    clinic_profile = ClinicProfile.create!(
        description: Faker::Company.catch_phrase,
        clinic: clinic
    )

    clinic_address = Address.create!(
        street: Faker::Address.street_name,
        number: Faker::Address.building_number,
        zipcode: Faker::Address.zip,
        state: Faker::Address.state,
        country: Faker::Address.country,
        city: Faker::Address.city,
        neighborhood: Faker::Address.community,
        latitude: Faker::Address.latitude,
        longitude: Faker::Address.longitude
    )

    clinic_profile.save if clinic_profile.address = clinic_address
end

10.times do |i|
    cpf = (i == 9 ? "01741053200" : Faker::Number.leading_zero_number(digits: 11))
    #cpf = Faker::Number.leading_zero_number(digits: 11)

    patient = Patient.create!(
        cpf: cpf,
        password: DEFAULT_PASSWORD_USER, 
        password_confirmation: DEFAULT_PASSWORD_USER,
        email: Faker::Internet.email,
        uid: cpf,
        provider: "cpf",
        confirmed_at: DateTime.now,

        name: Faker::Name.name,
        #genre: GENRES[[0,1].sample],
        #birth_date: Faker::Date.between(from: '1960-09-23', to: Date.today),
        #height: "1.#{Faker::Number.decimal_part(digits: 2)}".to_f,
        #bloodtype: BLOODTYPE[(0..5).to_a.sample],
        telephone: Faker::PhoneNumber.cell_phone_in_e164)
        #weight: "#{(40..90).to_a.sample}.#{Faker::Number.decimal_part(digits: 2)}".to_f)
    
    patient_profile = patient.patient_profile

    #patient_address = Address.create!(
    #    street: Faker::Address.street_name,
    #    number: Faker::Address.building_number,
    #    zipcode: Faker::Address.zip,
    #    state: Faker::Address.state,
    #    country: Faker::Address.country,
    #    city: Faker::Address.city,
    #    neighborhood: Faker::Address.community
    #)

    #patient_profile.save if patient_profile.address = patient_address

    patient_account = PatientAccount.create!(
        patient_profile: patient_profile        
    )
end

SPECIALITIES.each do |speciality|
    Speciality.create!(
        name: speciality[:d],
        description: Faker::Lorem.sentence(word_count: 10),
        priv: speciality[:v]
    )
end

10.times do |i|

    cpf = (i == 9 ? "01741053200" : Faker::Number.leading_zero_number(digits: 11))
    #cpf = Faker::Number.leading_zero_number(digits: 11)

    medic = Medic.create!(
        cpf: cpf,
        password: DEFAULT_PASSWORD_USER, 
        password_confirmation: DEFAULT_PASSWORD_USER,
        email: Faker::Internet.email,
        uid: cpf,
        provider: "cpf",
        confirmed_at: DateTime.now,
        
        name: Faker::Name.name,
        telephone: Faker::PhoneNumber.cell_phone_in_e164)

    medic_profile = medic.medic_profile

    if (i == 9)
        speciality = Speciality.where(priv: false).first
    else
        speciality = Speciality.all.sample
    end    
    
    medic_profile.save if medic_profile.specialities << speciality

    per_day = (1..15).to_a.sample
    days_of_week = "0#{[0,1].sample}#{[0,1].sample}#{[0,1].sample}#{[0,1].sample}#{[0,1].sample}0"
    if days_of_week.to_i == 0
        days_of_week[(0..6).to_a.sample] = "1"
    end

    clinic_profile = ClinicProfile.all.sample

    medic_work_scheduling = MedicWorkScheduling.create!(
        duration: 15,
        start_at: Time.new(Time.now.year, Time.now.month, Time.now.day, 8, 0, 0),
        end_at: Time.new(Time.now.year, Time.now.month, Time.now.day, 10, 0, 0),
        interval_start_at: Time.new(Time.now.year, Time.now.month, Time.now.day, 12, 0, 0),
        interval_end_at: Time.new(Time.now.year, Time.now.month, Time.now.day, 14, 0, 0),
        info: Faker::Lorem.sentence(word_count: 10),
        days_of_week: "0#{[0,1].sample}#{[0,1].sample}#{[0,1].sample}#{[0,1].sample}#{[0,1].sample}0",
        clinic_profile: clinic_profile,
        speciality: speciality,
        complement: Faker::Lorem.sentence(word_count: 10),
        medic_profile: medic_profile,

        medic_name: medic_profile.name,
        clinic_name: clinic_profile.name,
        speciality_name: speciality.name
    )

end