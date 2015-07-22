if Rails.env.development?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => "anbublacky@gmail.com",
    :password  => "znkKilSeVDeY6Z6xLs-wsw", # SMTP password is any valid API key
    :authentication => 'plain', # Mandrill supports 'plain' or 'login'
    :domain => 'localhost', # your domain to identify your server when connecting
  }
  ActionMailer::Base.default_url_options[:host] = "http://localhost:3000"
else
  ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => "anbublacky@gmail.com",
    :password  => "znkKilSeVDeY6Z6xLs-wsw", # SMTP password is any valid API key
    :authentication => 'plain', # Mandrill supports 'plain' or 'login'
    :domain => 'herokuapp.com', # your domain to identify your server when connecting
  }
  ActionMailer::Base.default_url_options[:host] = "https://evening-anchorage-9857.herokuapp.com"
end
