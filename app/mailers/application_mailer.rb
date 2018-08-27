class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@battleshift.io'
  layout 'mailer'
end
