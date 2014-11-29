class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	helper_method :current_user

	# before_action :current_user, :auth_log_in

	private

	def current_user
	  	@current_user ||= cookies[:user_id] && User.find(cookies[:user_id])
	end

	def auth_log_in
	  	unless current_user
	  		redirect_to log_in_path, error: "请先登陆"
	  	end
	end

end
