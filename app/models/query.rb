class Query < ActiveRecord::Base
  attr_accessible :query_string, :country_code, :enter_count, :user_id
  belongs_to :user
  validates :query_string,  :presence => true,
                     :length => { :within => 1..140 }
end
