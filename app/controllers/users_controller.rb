class UsersController < ApplicationController

  def new
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def edit_password
    @user = User.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])
    @user.update(user_params)
    
    if @user.save && param_passwords_match?
      flash[:success] = "Your password has been updated"
      redirect_to "/profile"
    elsif @user.save
      flash[:success] = "Your profile has been updated"
      redirect_to "/profile"
    elsif param_passwords_dont_match?
      flash[:error] = "passwords do not match"
      redirect_to "/users/#{@user.id}/edit_password"
    else
      flash[:error] = "Email has already been taken"
      redirect_to "/users/#{@user.id}/edit"
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.name}! You are now registered and logged in!"
      redirect_to "/profile"
    elsif email_exists?
      flash[:error] = "Email has already been taken"
      render :new
    elsif user_passwords_dont_match?
      flash[:error] = "Passwords did not match."
      render :new
    else
      flash[:notice] = "#{missing_params(user_params).join(", ")} can't be blank, please try again."
      render :new
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def user_passwords_dont_match?
    @user.password != @user.password_confirmation
  end

  def param_passwords_match?
    params[:password] == params[:password_confirmation] if params[:password] != nil
  end 

  def param_passwords_dont_match?
    params[:password] != params[:password_confirmation] if params[:password] != nil
  end 

  def email_exists?
    User.where(email: params[:email]).exists?
  end

  def missing_params(user_params)
    missing_params = []
    user_params.each do |key, value|
      if value == ""
        missing_params << "#{key}"
      end
    end
    missing_params
  end
end
