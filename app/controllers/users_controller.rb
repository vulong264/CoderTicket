class UsersController < ApplicationController
	
	def new
		@user = User.new
	end
	def create
		@user = User.new user_params
		if @user.save
			flash[:success] = "User created successfully"
			session[:user_id] = @user.id
			redirect_to root_path
		else
			render 'new'
		end
	end

	def index
		@users = User.list_all_user(session[:user_id])
	end

	def show
		
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
