class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.paginate(:page => params[:page], :per_page => 30)
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)

		if @user.save
			redirect_to admin_panel_path
		else
			render 'new'
		end
	end

	def new
		@user = User.new
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy

		redirect_to admin_panel_path
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to admin_panel_path
		else
			render 'edit'
		end
	end

	def admin
		@users = User.paginate(:page => params[:page], :per_page => 30)
	end

	private
	  def user_params
	    params.require(:user).permit(
	    	:email, :password, :password_confirmation, :admin, :approved, :_destroy
	    ) 
	  end

end
