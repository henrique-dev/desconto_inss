class Login < SitePrism::Page
  set_url '/'
  element :input_email, '#admin_email'
  element :input_password, '#admin_password'
  element :alert, '#error_explanation'

  def login(email, password)
    input_email.send_keys(email)
    input_password.send_keys(password)
    click_button 'Entrar'
  end

  def alert_message
    alert.text
  end
end
