module Users
  class Notifications < ApplicationMailer
  	def welcome(user)
	    @title = "Bienvenido al Sistema"
	    @subtitle = "Bienvenido al sistema de envios #{user.name} #{user.lastname}"
	    @user = user
	    @url = "http://exgerm.marpanet.com:3010/"
	    mail to: user.email, subject: "Bienvenido al sistema de Envios"
 	end
  end
end
