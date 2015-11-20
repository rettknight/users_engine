require_dependency "users/application_controller"

module Users
  class RelationshipsController < ApplicationController
	before_filter :authenticate
	def create
		user = User.find(params[:format])
		current_user.create_contact(user)
		redirect_to contacts_user_path(current_user)
	end
	def destroy
		Relationship.find(params[:id]).destroy
		redirect_to contacts_user_path(current_user)
	end
	private
		def authenticate
			deny_access unless signed_in? 
		end
  end
end