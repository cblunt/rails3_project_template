class ApplicationController < ActionController::Base
  protect_from_forgery
  authenticating_controller
end
