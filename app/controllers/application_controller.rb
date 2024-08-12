class ApplicationController < ActionController::Base
	# Method to find the current logged-in user
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	# Make current_user available in views
	helper_method :current_user

	# Redirect to login if user is not authenticated
	def authenticate_user!
		unless current_user
			redirect_to login_path, alert: "Please log in to continue."
		end
	end

	# Method to require admin access
	def require_admin
		unless current_user&.admin?
			redirect_to root_path, alert: "Access denied."
		end
	end
end
  