class SessionsController < ApplicationController
  skip_before_filter :login_required

  def index
    redirect_to login_path
  end

  def new
  end

  def create
    @user = User.authenticate(params[:email_address], params[:password])

    if @user
      session[:user_id] = @user.id
      flash[:success] = "You are now logged in."
      redirect_to root_path and return
    else
      flash[:error] = "Your account could not be authenticated."
      render :new
    end
  end

  def destroy
  end
end
