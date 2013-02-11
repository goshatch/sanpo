include ApplicationHelper

def fillin_and_signin(user)
  within ".signin" do
    fill_in "Username or email",  with: user.username
    fill_in "Password",           with: user.password
    click_button "Sign in"
  end
end

RSpec::Matchers.define :have_alert_message do |message|
  match do |page|
    page.should have_selector( "div.alert-message" , text: message )
  end
end

