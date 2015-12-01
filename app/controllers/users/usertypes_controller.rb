require_dependency "users/application_controller"

module Users
  class UsertypesController < ApplicationController
    before_action :set_usertype, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate
    def index
      @title = 'Tipos de usuarios'
      @usertypes = Usertype.all
    end
    def show
    end
    def new
      @usertype = Usertype.new
    end
    def edit
    end
    def create
      @usertype = Usertype.new(usertype_params)

      respond_to do |format|
        if @usertype.save
          format.html { redirect_to @usertype, notice: 'Tipo de usuario creado.' }
          format.json { render :show, status: :created, location: @usertype }
        else
          format.html { render :new }
          format.json { render json: @usertype.errors, status: :unprocessable_entity }
        end
      end
    end
    def update
      respond_to do |format|
        if @usertype.update(usertype_params)
          format.html { redirect_to @usertype, notice: 'Tipo de usuario actualizado.' }
          format.json { render :show, status: :ok, location: @usertype }
        else
          format.html { render :edit }
          format.json { render json: @usertype.errors, status: :unprocessable_entity }
        end
      end
    end
    def destroy
      @usertype.destroy
      respond_to do |format|
        format.html { redirect_to usertypes_url, notice: 'Tipo de usuario destruido.' }
        format.json { head :no_content }
      end
    end
    private
    def set_usertype
      @usertype = Usertype.find(params[:id])
    end
    def authenticate
      if signed_in?
        deny_access unless current_user.admin?
      else
        deny_access
      end
    end
    def usertype_params
      params.require(:usertype).permit(:name)
    end
  end
end