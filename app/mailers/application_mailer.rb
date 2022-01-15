# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@qotofey.ru'
  layout 'mailer'
end
