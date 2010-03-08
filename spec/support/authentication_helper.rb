def login_as(user)
  current_user = Factory.create(:user)
  controller.stubs(:current_user).returns(current_user)
end
