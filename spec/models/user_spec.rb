require 'spec_helper'

describe User do

  before(:each) do
    @valid_attributes = {}
    @valid_attributes[:login] = "bob"
    @valid_attributes[:email] = "bob@example.com"
    @valid_attributes[:password] = "password"
    @valid_attributes[:password_confirmation] = "password"
    @user = User.create(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @user.save.should == true
  end

  it { should have_many(:recipes) }

  it "sorts recipes by name" do
    @user.recipes << Recipe.new(:title => "b")
    @user.recipes << Recipe.new(:title => "a")

    @user.recipes.first.title.should == "a"
    @user.recipes.second.title.should == "b"
  end

  it "should authenticate valid user" do
    @authenticated = User.authenticate("bob", "password")

    @authenticated.should_not be_nil
    @authenticated.id.should == @user.id
  end

  it "should not authenticate with incorrect password" do
    @authenticated = User.authenticate("bob", "wrong password")

    @authenticated.should be_nil
  end

  it "should not authenticate for login that isn't found" do
    @authenticated = User.authenticate("notbob", "password")

    @authenticated.should be_nil
  end

  it "should hash when setting the password" do
    @user = User.new
    @user.password = "foobar"

    @user.salt.should_not be_nil
    @user.hashed_password.should == User.encrypt(@user.password, @user.salt)
  end

  describe "validations" do

    it { should validate_presence_of(:login) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_presence_of(:salt) }

    it { should validate_uniqueness_of(:login) }
    it { should validate_uniqueness_of(:email) }

    it "should validate format of email address" do
      @user.email = "bad@email."

      @user.save

      @user.errors[:email].should include("is invalid")
    end

    it "should validate length of password" do
      @user.password = "123"

      @user.save

      @user.errors[:password].should include("is too short (minimum is 6 characters)")
    end

    it "should validate confirmation of password" do
      @user.password = "password"
      @user.password_confirmation = "not password"

      @user.save

      @user.errors[:password].should include("doesn't match confirmation")
    end
  end

end
