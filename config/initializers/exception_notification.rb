Rails.application.config.middleware.use ExceptionNotification::Rack,
  :email => {
    :email_prefix => "Rails Basic setup App :",
    :sender_address => %{rails_basic_setup@udproducts.in},
    :exception_recipients => %w{anbublacky@gmail.com}
  }