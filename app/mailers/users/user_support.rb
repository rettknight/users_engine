module Users
  class UserSupport < ApplicationMailer
	def password_reset(user)
		@subtitle = "Petición de cambio de contraseña"
		@user = user 
		@url = "http://exgerm.marpanet.com:3010/password_resets/#{@user.password_reset_token}/edit"
		mail :to => user.email, :subject => "Restablecimiento de contraseña"
	end
  end
end
