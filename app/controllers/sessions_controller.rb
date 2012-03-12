class SessionsController < ApplicationController
  def new
  	@title = "Sign In"
  end

  def create
  	user = User.find_by_email(params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		# Sign the user and redirect to its profile page
			sign_in user
			redirect_to user
		else
			# Error! render the sign in page with some error message
			flash.now[:error] = "Invalid Username/Password combination"
			@title = "Sign in"
		  render 'new'
		end

  end

	def destroy
		sign_out
		redirect_to root_path
	end
end
