require_dependency "users/application_controller"

module Users
  class SessionsController < ApplicationController
    def new
      @title = 'Inicio de sesion'
      @desc = 'Favor de iniciar antes de ver las acciones disponibles.' #Template messages
    end
    def create
      user = User.authenticate(params[:session][:email],
                               params[:session][:password])
      if user.nil?
        flash.now[:error] = 'Datos incorrectos'
        @title = 'Inicio de sesion'
        @desc = 'Favor de iniciar antes de ver las acciones disponibles.' #Template messages

        render 'new'
      else
        sign_in user unless user.active == 0
        if user.active == 1
          redirect_back_or user
        else
          redirect_to root_path, :flash => {:notice => 'Cuenta desactivada. '}
        end
      end
    end
    def destroy
      sign_out
      redirect_to root_path
    end
    def session_params
      session_params.require(:session).permit(:email,:password)
    end
  end
end