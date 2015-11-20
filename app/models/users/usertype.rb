module Users
  # == Tipos de Usuario Predeterminadods
  #
  # 1 = Miembro
  # 2 = Admin
  #
  # == Schema Information
  #
  # Table name: usertypes
  #
  #  id   :integer          not null, primary key
  #  name :string(255)
  #
  class Usertype < ActiveRecord::Base
    has_many :users, :foreign_key => 'userType_id'
    validates :name, :presence => true
  end
end
