class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = params[:role].present? ? User.send(params[:role]) : User.all
  end

  def new
  	@user = User.new(role: params[:role])
  end

  def create
  	@user = User.new user_params
  	
  	if @user.save
  		redirect_to users_path(role: @user.role), notice: 'Created successfully'
  	else
  		flash[:error] = @user.errors.full_messages.to_sentence
  		render :new
  	end
  end

  def update
  	@user_params = user_params
  	@user_params.delete(:password) unless @user_params[:password].present?
  	@user_params.delete(:password_confirmation) unless @user_params[:password_confirmation].present?

  	p @user_params

  	if @user.update @user_params
  		redirect_to users_path(role: @user.role), notice: 'Updated successfully'
  	else
  		flash[:error] = @user.errors.full_messages.to_sentence
  		render :edit
  	end
  end

  def destroy
  	if @user.destroy
  		redirect_to users_path(role: @user.role), notice: 'Destroyed successfully'
  	else
  		flash[:error] = @user.errors.full_messages.to_sentence
  		redirect_to users_path(role: @user.role)
  	end
  end

  private ##

  def set_user
  	@user = User.find_by id: params[:id]
  end

  def user_params
  	params.require(:user).permit(
  		:ssn, :zip_code, :phone_number, :first_name, :dob, :role, :status,
      :last_name, :street_address_1, :street_address_2,  :postcode, 
      :city, :state, :email, :password, :password_confirmation
    )
  end
end