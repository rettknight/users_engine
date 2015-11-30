# desc "Explaining what the task does"
# task :users do
#   # Task goes here
# end
task :users do 
	admin = Users::User.new(:name => "Admin", :email => "admin", 
			:password => "doseli", :userType_id => "2")
	admin.save(validate: false)
end