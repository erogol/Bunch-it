class Folder < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :docs
  attr_accessible :folder_name, :user_id
end
