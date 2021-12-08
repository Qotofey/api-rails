class PasswordResetMailer < ApplicationMailer
  def make
    @user = params[:user]
    mail(to: @user.email, subject: 'Сброос пароля | qotofey.ru')
  end
end
