require_dependency "users/application_controller"

module Users
  class UsersController < ApplicationController
  before_filter :authenticate, except: [:new, :create] #Remove except if only admin can register new users
  before_filter :correct_user, only: [:edit, :update, :disable]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :disable]
  before_filter :admin_user, only: [:destroy, :adminpanel]
  def index
    if current_user.admin? 
    @users = User.paginate(:page => params[:page], per_page: 15)
    @title = 'Todos los usuarios'
    else 
    redirect_to current_user
    end  
  end
  def adminpanel
   last_connected
    @title = 'Admin Panel'
    @newuser = User.new
  end
  def show
    last_connected
    @title = @user.name
  end
  def contacts
    @title = 'Contactos'
    @user = User.find(params[:id])
    @users = @user.contacts.paginate(:page => params[:page])
    render 'show_contacts'
  end
  def new
    @user = User.new
    @title = 'Iniciar sesión'
  end
  def create
    if current_user.nil? 
      @user = User.new(user_params)
      if @user.save
        flash[:notice] = 'Usuario registrado correctamente.'
        sign_in @user
        redirect_to @user
        Notifications.welcome(@user).deliver_now
      else
       render 'new'
      end
    elsif current_user.admin? 
      @newuser = User.new(user_params)
       if @newuser.save 
         flash[:notice] = 'User registrado correctamente. '
         redirect_to adminpanel_users_path
       else
         render "adminpanel"
       end
    end
  end 
  def edit
    @title = 'Editar usuario'
  end
  def update
    case params[:commit]
      when 'Actualizar'
        if @user.update_attributes(user_params)
          redirect_to @user, :flash =>{:success => 'User information changed.'}
          @user.update_attributes(:updatedAt => Time.now, :lastConnection => Time.now)
        else
          render 'edit'
          @title = "Edit user"
        end
      when 'Actualizar contraseña' #Checar como activar el utf-8 o cambiar a otro valor de commit
        @user.update_attributes(user_params)
        if @user.save
          redirect_to root_path, :flash => {:success => 'Contraseña actualizada'}
        else
          render 'forgot'
        end
      else
        if current_user == @user
          @user.active = '0'
          @user.deletedAt = Time.now
          @user.updatedAt = Time.now
          @user.save(validate: false)
          sign_out
          redirect_to root_path
        elsif current_user.admin?
          @user.active = '0'
          @user.deletedAt = Time.now
          @user.updatedAt = Time.now
          @user.save(validate: false)
          redirect_to adminpanel_users_path, :flash => {:success => 'Cuenta desactivada. '}
        end
    end
  end
  def destroy
    if @user.admin? 
      redirect_to root_path, :flash => {:error => "Admins can't delete themselves. "}
    else
      @user.destroy
      redirect_to users_path, :flash => {:success => 'User deleted.'}
    end
  end
  private
    def authenticate
      deny_access unless signed_in? 
    end
    def correct_user
      @user = User.find(params[:id])
      if !current_user.nil?
       redirect_to(root_path) unless current_user?(@user) || current_user.admin? 
      end
    end
    def set_user
      @user = User.find(params[:id])
    end
    def admin_user
      redirect_to(root_path) unless current_user.admin? 
      flash[:notice] = 'No tienes permiso de accesar esta pagina. ' if !current_user.admin?
    end
    def user_params
      params.require(:user).permit(:active, :lastConnection, :updatedAt, :name, :email, :password, :password_confirmation, :lastname, :userType_id)
    end
  end
end