class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	helper_method :current_user, :current_cart, :all_region, :all_category #provide access to :current_user function for views
	helper_method :current_cart


	protected
	#this function getting data from session object to pass to view layer
	def current_user
		return @current_user if @current_user
		if session[:user_id]
			@current_user = User.find session[:user_id]
		end
	end

	def all_region
		@all_region = Region.all
	end

	def all_category
		@all_category = Category.all
	end

	def require_user!
		unless current_user
			flash[:success] = "please login first."
			redirect_to new_session_path
		end
	end

  
  def current_cart
    @current_cart = Cart.find_or_create_by(user_id: current_user.id,checked_out_at: nil)
  end
end
