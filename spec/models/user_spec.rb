require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :login => "bob",
      :email => "bob@example.com",
      :password => "password",
      :password_confirmation => "password"
    }
    @user = User.create(@valid_attributes)
  end

  it "sorts recipes by name" do
    @user.recipes << Recipe.new(:title => "b")
    @user.recipes << Recipe.new(:title => "a")

    @user.recipes.first.title.should == "a"
    @user.recipes.second.title.should == "b"
  end

  it "authenticates valid user" do
    @authenticated = User.authenticate("bob", "password")

    @authenticated.should_not be_nil
    @authenticated.id.should == @user.id
  end

  it "does not authenticate with incorrect password" do
    @authenticated = User.authenticate("bob", "wrong password")

    @authenticated.should be_nil
  end

  it "does not authenticate for missing login" do
    @authenticated = User.authenticate("notbob", "password")

    @authenticated.should be_nil
  end

  it "hashes the password" do
    @user = User.new
    @user.password = "foobar"

    @user.salt.should_not be_nil
    @user.hashed_password.should == User.encrypt(@user.password, @user.salt)
  end

  describe "validations" do
    it "login is required" do
      @user.login = nil
      @user.valid?
      @user.errors[:login].should include("can't be blank")

      @user.login = "bob"
      @user.should be_valid
    end

    it "email is required" do
      @user.email = nil
      @user.valid?
      @user.errors[:email].should include("can't be blank")

      @user.email = "bob@example.com"
      @user.should be_valid
    end

    it "password is required" do
      @user.password = nil
      @user.valid?
      @user.errors[:password].should include("can't be blank")

      @user.password = "password"
      @user.should be_valid
    end

    it "password_confirmation is required" do
      @user.password_confirmation = nil
      @user.valid?
      @user.errors[:password_confirmation].should include("can't be blank")

      @user.password_confirmation = "password"
      @user.should be_valid
    end

    it "salt is required" do
      @user.salt = nil
      @user.valid?
      @user.errors[:salt].should include("can't be blank")

      @user.salt = "pepper"
      @user.should be_valid
    end

    it "login is unique" do
      duplicate_user = User.new(@valid_attributes)
      duplicate_user.valid?
      duplicate_user.errors[:login].should include("has already been taken")

      duplicate_user.login = "notbob"
      duplicate_user.email = "notbob@example.com"
      duplicate_user.should be_valid
    end

    it "email is unique" do
      duplicate_user = User.new(@valid_attributes)
      duplicate_user.valid?
      duplicate_user.errors[:email].should include("has already been taken")

      duplicate_user.email = "notbob@example.com"
      duplicate_user.login = "notbob"
      duplicate_user.should be_valid
    end

    it "email address is valid" do
      @user.email = "bad@email."
      @user.valid?
      @user.errors[:email].should include("is invalid")

      @user.email = "good@example.com"
      @user.should be_valid
    end

    it "password is at least 6 characters" do
      @user.password = "12345"
      @user.valid?
      @user.errors[:password].should include("is too short (minimum is 6 characters)")

      @user.password = "123456"
      @user.password_confirmation = "123456"
      @user.valid?
      @user.should be_valid
    end

    it "password_confirmation must match password" do
      @user.password = "password"
      @user.password_confirmation = "not password"
      @user.valid?
      @user.errors[:password].should include("doesn't match confirmation")

      @user.password_confirmation = "password"
      @user.should be_valid
    end
  end
end
