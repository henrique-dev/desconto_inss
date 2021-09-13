DEFAULT_PASSWORD_ADMIN = 'ZXDas7966mby@'
DEFAULT_PASSWORD_USER = '123456'

Admin.create!(email: 'admin1@dss.com', password: DEFAULT_PASSWORD_ADMIN, password_confirmation: DEFAULT_PASSWORD_ADMIN)
Admin.create!(email: 'admin2@dss.com', password: DEFAULT_PASSWORD_ADMIN, password_confirmation: DEFAULT_PASSWORD_ADMIN)
Admin.create!(email: 'admin3@dss.com', password: DEFAULT_PASSWORD_ADMIN, password_confirmation: DEFAULT_PASSWORD_ADMIN)

1000.times do |i|
    cpf = (i == 9 ? "01741053200" : Faker::Number.leading_zero_number(digits: 11))
    wage = "#{Random.rand(8)+1}#{Random.rand(8)+1}00".to_f

    user = User.create!(
        name: Faker::Name.name,
        cpf: cpf,
        birth_date: Faker::Date.between(from: "1960-09-23", to: "1999-01-01"),
        wage: wage,
        deduction: User.calculate_deduction(wage)
    )

    user_address = Address.create!(
        street: Faker::Address.street_name,
        number: Faker::Address.building_number,
        zipcode: Faker::Address.zip,
        state: Faker::Address.state,
        city: Faker::Address.city,
        neighborhood: Faker::Address.community
    )

    user.address = user_address
    user.save


end