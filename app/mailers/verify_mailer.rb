class VerifyMailer < ApplicationMailer
  default from: 'no-reply@pdconline.org.cn'

  def code
    @locale = params[:locale]
    @verify_code = params[:verify_code]
    @mail = params[:email]
    mail(to: @mail, subject: @locale == 'en' ? "Verify code" : "验证码")
  end
  
end
