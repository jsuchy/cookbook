TEST_USER_NAME = "tester"
TEST_USER_PASSWORD = "password"
INVALID_USER_NAME = "developer"
INVALID_USER_PASSWORD = "passwd"

Given /^there is a test user$/ do
  User.create!(:login => TEST_USER_NAME, :password => TEST_USER_PASSWORD, :password_confirmation => TEST_USER_PASSWORD, :email => "tester@example.com")
end

When /^I login with the test user's credentials$/ do
  login_with(TEST_USER_NAME, TEST_USER_PASSWORD)
end

When /^I login with invalid credentials$/ do
  login_with(INVALID_USER_NAME, INVALID_USER_PASSWORD)
end

def login_with(user_name, password)
  fill_in("user", :with => user_name)
  fill_in("password", :with => password)
  click_button('login')
end
