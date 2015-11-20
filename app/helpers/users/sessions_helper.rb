module Users
  module SessionsHelper
    def sign_in(user)
      if params[:remember_me]
        cookies.permanent.signed[:remember_token] = [user.id, user.salt]
      else
        cookies.signed[:remember_token] = [user.id, user.salt]
      end
      current_user = user
      last_connected
    end
    def current_user=(user)
      @current_user = user
    end
    def current_user
      @current_user ||= user_from_remember_token
    end
    def signed_in?
      !current_user.nil?
    end
    def sign_out
      cookies.delete(:remember_token)
      current_user = nil
    end
    def current_user?(user)
      user == current_user
    end
    def last_connected
      current_user.lastConnection = Time.now
      current_user.save(validate: false)
    end
    def deny_access
      if signed_in?
        redirect_to root_path, :flash => {:error => "No tienes permiso de accesar a esta pagina. "}
      else
        store_location
        redirect_to signin_path, :notice => "Inicia sesion antes de continuar. "
      end
    end
    def store_location
      session[:return_to] = request.fullpath
    end
    def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      clear_return_to
    end
    def clear_return_to
      session[:return_to] = nil
    end
    private
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
  end
end
