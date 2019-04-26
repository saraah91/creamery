class DemosController < ApplicationController
    def new
    end
    
    def create
       user = User.find_by(email: params[:demo][:email].downcase) 
    #   puts "******************************* #{params[:demo][:email]}"
       if user && user.authenticate(params[:demo][:password])
        #   puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% #{user.email}"
        #   puts "Authenticated"
           login(user)
            respond_to do |format|
                format.html { redirect_to user, notice: 'Welcome '+ user.employee.name }
                format.json { head :no_content }
            end       
        else
           flash.now[:danger] = "Invalid email or password"
           render 'new'
       end
    end
    
    def destroy
        logout
        redirect_to root_url
    end

end
