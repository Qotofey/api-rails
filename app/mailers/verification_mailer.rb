class VerificationMailer < ApplicationMailer
  def make
    @user = params[:user]
    mail(to: @user.email, subject: 'Подтверждение регистрации | qotofey.ru')
  end
end
