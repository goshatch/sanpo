shared_examples_for "sign-in page" do
  it { should have_content('Sign in!') }
end

shared_examples_for "sign-up page" do
  it { should have_content('Please sign up!') }
  it_should_behave_like "non-signed in user page"
end

shared_examples_for "signed up page" do
  it_should_behave_like "signed in user page"
  it { should have_alert_message("Welcome! You have signed up successfully.") }
end

shared_examples_for "signed in page" do
  it_should_behave_like "signed in user page"
  it { should have_alert_message("Signed in successfully.") }
end

shared_examples_for "signed out page" do
  it_should_behave_like "non-signed in user page"
  it { should have_alert_message("Signed out successfully.") }
end

shared_examples_for "signed in user page" do
  it { should have_link( user.username, href: user_profile_path(user.username)) }
  it { should have_link( "Account", href: "#") }
  it { should have_link( "Edit my account", href: edit_user_registration_path )}
  it { should have_link( "Sign out", href: destroy_user_session_path )}
  it { should_not have_link( "Sign in", href: new_user_session_path) }
end

shared_examples_for "non-signed in user page" do
  it { should_not have_link( "Account", href: "#") }
  it { should_not have_link( "Edit my account", href: edit_user_registration_path )}
  it { should_not have_link( "Sign out", href: destroy_user_session_path )}
  it { should have_link( "Sign in", href: new_user_session_path) }
  it { should have_link( "Create an account", href: new_user_registration_path) }
end
