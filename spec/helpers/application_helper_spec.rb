require 'spec_helper'

describe ApplicationHelper do

  it "should recognize iphone user agent" do
    request = mock("request", :user_agent => "Version/3.0 Mobile/4A93 Safari/419.3")

    helper.iphone_user_agent?(request).should be_true
  end

  it "should recognize non-iphone user agent" do
    request = mock("request", :user_agent => "Mozilla")

    helper.iphone_user_agent?(request).should be_false
  end

  it "should know if a user is logged in" do
    session[:user_id] = 42

    helper.logged_in?.should == true
  end

  it "should know if a user is not logged in" do
    session[:user_id] = nil

    helper.logged_in?.should == false
  end

end
