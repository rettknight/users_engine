module Users
  class Picture < ActiveRecord::Base
  	belongs_to :user
  	has_attached_file :url,	
  		url: "/assets/pictures/:id/:basename.:extension", 
  		path: ":rails_root/public/assets/pictures/:id/:basename.:extension"
  	validates_attachment_presence :url, on: :create 
  	validates_attachment_content_type :url, content_type: %w(image/png image/jpeg image/jpg)	
  end
end