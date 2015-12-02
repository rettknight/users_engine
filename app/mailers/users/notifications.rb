module Users
  class Notifications < ApplicationMailer
  	def welcome(user)
	    @title = "Bienvenido al Sistema"
	    @subtitle = "Bienvenido al sistema #{user.name} #{user.lastname}"
	    @user = user
	    @url = "http://exgerm.marpanet.com:3010/"
	    mail to: user.email, subject: "Bienvenido al sistema"
 	end
  end
end
