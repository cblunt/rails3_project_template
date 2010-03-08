require 'spec_helper'

describe SessionsController do
  context "GET index" do
    it { get :index; response.should redirect_to login_path }
  end

  context "GET new" do
    before :each do
      get :new
    end

    it { response.should be_success }
    it { response.should render_template :new }
  end

  context "POST create" do
    context "with invalid credentials" do
      before :each do
        User.expects(:authenticate).with("invalid", "secret").returns(nil)
        post :create, :email_address => "invalid", :password => "secret"
      end

      it { response.should be_success }
      it { response.should render_template :new }
      it { session[:user_id].should be_nil }
      it { flash[:error].should_not be_blank }
    end

    context "with valid credentials" do
      before :each do
        User.expects(:authenticate).with("valid", "secret").returns(Factory.create(:user))
        post :create, :email_address => "valid", :password => "secret"
      end

      it { response.should redirect_to root_path }
      it { session[:user_id].should_not be_nil }
      it { flash[:success].should_not be_blank }
    end
  end
  
  # NOTE Logging out specs are pending. Problems setting session[] attributes in Rails 2.
  it "should log out the user"
  # context "DELETE destroy" do
  #   before :each do 
  #     login_as :user
  #     delete :destroy
  #   end

  #   it { response.should redirect_to root_path }
  #   it { assigns(:current_user).should be_blank }
  #   it { flash[:success].should_not be_blank }
  # end
end
