task :precreate_profiles => :environment do
  users = User.find(:all)
  for user in users do
    if user.profile
      puts "User ##{user.id} has a profile..."
    else
      puts "User ##{user.id} doesn't have a profile, creating!"
      Profile.create(:user => user)
    end
  end
end
