class UsersController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:success] = "Registration successful. Please check your emails to verify your account."
      redirect_to root_path and return
    else
      flash[:error] = "Your account could not be created. Please correct any problems and try again."
      render :new and return
    end
  end
end
