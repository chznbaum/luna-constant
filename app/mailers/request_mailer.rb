class RequestMailer < ApplicationMailer

  # Subject can be set in your Il8n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.contact.subject
  #
  def request_invitation(request)
    @request = request
    mail to: @admin_email, from: @request.email, subject: "Invitation Request from #{@request.name} <#{@request.email}>"
  end
end