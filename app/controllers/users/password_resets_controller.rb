require_dependency "users/application_controller"

module Users
  class PasswordResetsController < ApplicationController
    before_filter :authenticate
    def new
    end
    def index
      render 'new'
    end
    def create
      user = User.find_by_email(params[:search])
      if !user.nil?
        user.send_password_reset
        redirect_to root_path, :notice => 'Instrucciones enviadas. '
      else
        render 'new', :notice => 'No existe el usuario.'
      end
    end
    def edit
      @user = User.find_by_password_reset_token!(params[:id])
    end
    def update
      @user = User.find_by_password_reset_token(params[:id])
      if @user.time_requested < 2.hours.ago
        redirect_to new_password_reset_path, :alert => 'Ha expirado el lapso de tiempo.'
      elsif @user.update_attributes(user_params)
        redirect_to root_url, :notice => 'Contraseña cambiada'
      else
        render 'edit'
      end
    end
    private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    def authenticate
      deny_access if signed_in? && !current_user.admin?
    end
  end
end
