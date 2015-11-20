module Users
  # == Schema Information
  #
  # Table name: relationships
  #
  #  id         :integer          not null, primary key
  #  owner_id   :integer
  #  contact_id :integer
  #  created_at :datetime         not null
  #  updated_at :datetime         not null
  #
  class Relationship < ActiveRecord::Base
    belongs_to :owner, :foreign_key => "contact_id",
               :class_name => "User"
    validates :owner_id, :presence => :true
    validates :contact_id, :presence => :true
  end
end