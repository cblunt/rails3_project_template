require 'spec_helper'

describe User do
  before :each do
    @user = Factory.create(:user)
  end

  it "should be valid" do
    @user.should be_valid
  end

  it "should validate presence of email address" do
    @user.email_address = nil
    @user.should_not be_valid
    @user.errors[:email_address].should include "can't be blank"
  end

  it "should validate format of email address" do
    ['joe', 'joe@', 'joe@example', 'joe@example.c', 'joe@e.c'].each do |fixture|
      @user.email_address = fixture
      @user.should_not be_valid
      @user.errors[:email_address].should include "is invalid"
    end
  end

  it "should validate presence of username" do
    @user.username = nil
    @user.should_not be_valid
    @user.errors[:username].should include "can't be blank"
  end

  it "should validate format of username" do
    ['+4320-9', '££$$'].each do |fixture|
      @user.username = fixture
      @user.should_not be_valid
     @user.errors[:username].should include "is invalid"
    end
  end

  it "should validate confirmation of password" do
    @user = Factory.build(:user, :password => "password")
    @user.password_confirmation = "notpassword"
    @user.should_not be_valid
    @user.errors[:password].should include "doesn't match confirmation"
  end 

  context "registration" do
    it "should set a hashed password before saving" do
      @user = Factory.build(:user)
      @user.password_hash.should be_blank
      @user.password_salt.should be_blank

      @user.save!

      @user.password_hash.should_not be_blank
      @user.password_salt.should_not be_blank
    end

    it "should generate a random verification key" do
      @user = Factory.build(:user, :verification_key => nil, :verified_at => nil)
      @user.save!
      @user.verification_key.should_not be_blank
    end

    it "should not be verified" do
      @user = Factory.build(:user, :verification_key => nil, :verified_at => nil)
      @user.save!
      @user.verified_at.should be_blank
    end
  end

  context "verification" do
    it "should not verify with an incorrect verification key" do
      @user = Factory.create(:user, :verified_at => nil)
      @user.verify('invalid-key').should be_false
      @user.should_not be_verified
    end

    it "should not verify when already verified" do
      @user = Factory.create(:user)
      @user.verify(@user.verification_key).should be_false
      @user.should be_verified
    end

    it "should verify with a valid verification key" do
      @user = Factory.create(:user, :verified_at => nil)
      @user.verify(@user.verification_key).should be_true
      @user.should be_verified
    end
  end

  context "authentication" do
    it "should not authenticate an invalid email address" do
      User.authenticate("invalid@example.com", "secret").should be_nil
    end

    it "should not authenticate an invalid password" do
      User.authenticate(@user.email_address, "invalid").should be_nil
    end

    it "should not authenticate an unverified user" do
      @user.update_attribute(:verified_at, nil)
      User.authenticate(@user.email_address, "secret").should be_nil
    end

    it "should authenticate a verified user" do
      authenticated_user = User.authenticate(@user.email_address, "secret")
      authenticated_user.should be_a User
      authenticated_user.id.should eql @user.id
    end
  end
end
