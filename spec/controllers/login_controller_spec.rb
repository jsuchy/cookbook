require 'spec_helper'

describe LoginController do

  describe "attempt login with valid credentials" do

    before(:each) do
      @user = mock(User, :id => 42)
      User.should_receive(:authenticate).with("bilbo", "baggins").and_return(@user)

      post :attempt_login, :user => "bilbo", :password => "baggins"
    end

    it "should set the user" do
      assigns[:user].should == @user
    end

    it "should set the session" do
      session[:user_id].should == 42
    end

    it "should redirect to recipes" do
      response.should redirect_to(:controller => "recipes", :action => "index")
    end

  end

  describe "attempt login with invalid credentials" do

    before(:each) do
      User.should_receive(:authenticate).with("frodo", "baggins").and_return(nil)

      post :attempt_login, :user => "frodo", :password => "baggins"
    end

    it "should render the index" do
      response.should redirect_to(:controller => "login", :action => "index")
    end

    it "should set the flash" do
      flash[:error].should == "Invalid username or password."
    end

  end

  describe "logout" do

    before(:each) do
      session[:user_id] = 42

      post :logout
    end

    it "should reset session" do
      session[:user_id].should be_nil
    end

    it "should redirect to the login page" do
      response.should redirect_to(:controller => "login", :action => "index")
    end

  end

end
