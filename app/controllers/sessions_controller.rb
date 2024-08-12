class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
			if user.admin?
      	redirect_to admin_products_path, notice: "Logged in successfully."
			else
				flash.now[:alert] = "Login/Signup as Administrator"
      	render :new
			end
    else
      flash.now[:alert] = "Invalid username or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully."
  end
end

