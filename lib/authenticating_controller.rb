module AuthenticatingController
  def authenticating_controller
    before_filter :login_required
    helper_method :current_user

    include InstanceMethods
  end

  module InstanceMethods
    def current_user
      return nil unless session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end

  protected
    def login_required
      unless current_user
        flash[:notice] = "You must be logged in to continue."
        redirect_to login_path and return
      end
    end
  end
end

ActionController::Base.extend AuthenticatingController


