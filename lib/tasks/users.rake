namespace :users do
	
	desc "STUUFFF"
	task :op do 
	admin = Users::User.new(:name => "Admin", :email => "admin", 
			:password => "doseli", :userType_id => "2")
	admin.save(validate: false)
	end
end
