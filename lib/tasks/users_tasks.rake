# desc "Explaining what the task does"
# task :users do
#   # Task goes here
# end
desc "TASK STUFF!!! "
task :users do 
	puts "popo"
	admin = Users::User.new(:name => "Admin", :email => "admin", 
			:password => "doseli", :userType_id => "2")
	admin.save(validate: false)
end