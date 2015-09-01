desc "This task is called by the Heroku scheduler add-on"
task :test_time => :environment do
  TestTime.create(text: Time.current.to_s)
  puts "created"
end
