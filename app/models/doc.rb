class Doc < ActiveRecord::Base
  has_and_belongs_to_many :folders
  attr_accessible :title, :url, :snippet
end
