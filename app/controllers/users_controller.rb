class UsersController < ApplicationController

  def show
  	@user = User.find(params[:id])
  	@title = @user.name
  end

  def new
  	@user = User.new
  	@title = "Sign up"
  end
  def create
  	@user = User.new(params[:user])
  	if @user.save
  		#saved successfully
  		sign_in @user
  		flash[:success] = "Welcome to Mblog App!"
  		redirect_to @user
  	else
  		@title = "Sign up"
  		render 'new'
  	end
  end
end
