class ApplicationMailer < ActionMailer::Base
  default from: @admin_email
  layout 'mailer'
end
