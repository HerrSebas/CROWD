ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: 'gmail.com',
  user_name: ENV.fetch('GMAIL_ADDRESS'),
  password: ENV.fetch('GMAIL_APP_PASSWORD'),
  authentication: :login,
  enable_starttls_auto: true
}
