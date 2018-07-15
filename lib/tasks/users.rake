namespace :users do
  desc "Create example users"
  task create_users: :environment do
    # Create example users
    User.create!([
      email: 'andy@example.com',
      password: 'User#1',
      password_confirmation: 'User#1'
    ])
    User.create!([
      email: 'john@example.com',
      password: 'User#2',
      password_confirmation: 'User#2'
    ])
    User.create!([
      email: 'lisa@example.com',
      password: 'User#3',
      password_confirmation: 'User#3'
    ])
    User.create!([
      email: 'common@example.com',
      password: 'User#4',
      password_confirmation: 'User#4'
    ])
    User.create!([
      email: 'kate@example.com',
      password: 'User#5',
      password_confirmation: 'User#5'
    ])
  end

end
