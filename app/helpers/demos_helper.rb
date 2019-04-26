module DemosHelper
    def login(user)
        session[:user_id] = user.id
    end
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def current_users_role
        @role = current_user.employee.role
    end
    
    def logged_in?
       !current_user.nil?
    end
    
  def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
  end
    
    def logout
        session.delete(:user_id)
        flash[:danger] = "You logged out successfuly."
        @current_user = nil
    end
    
    def role
        self.employee.role
    end
end
