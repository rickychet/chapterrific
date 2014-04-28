module SessionsHelper
  
  def sign_in(user)
      remember_token = User.new_remember_token
      cookies.permanent[:remember_token] = remember_token
      user.update_attribute(:remember_token, User.hash(remember_token))
      self.current_user = user
    end
    
    def signed_in?
       !current_user.nil?
     end
    
    def current_user=(user)
        @current_user = user
    end

    def current_user?(user)
      user == current_user
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url
      end
    end
    
    def current_user
        remember_token = User.hash(cookies[:remember_token])
        @current_user ||= User.find_by(remember_token: remember_token)
    end  

    def store_location
      session[:return_to] = request.url
    end
end
