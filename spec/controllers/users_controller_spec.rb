require 'spec_helper'

describe UsersController do

  describe "GET new" do
    before :each do
      get :new
    end
  
    it { response.should be_success }
    it { response.should render_template :new }
    it { assigns(:user).should be_a User }
    it { assigns(:user).should be_new_record }
  end

  describe "POST create" do
    context "with invalid details" do
      before :each do
        User.any_instance.expects(:save).returns(false)
        post :create
      end

      it { response.should be_success }
      it { response.should render_template :new }
      it { assigns(:user).should be_a User }
      it { assigns(:user).should be_new_record }
      it { flash[:error].should_not be_blank }
    end

    context "with valid details" do
      before :each do 
        User.any_instance.expects(:save).returns(true)
        post :create
      end
      
      it { response.should redirect_to root_path }
      it { flash[:success].should_not be_blank }
    end
  end
end
