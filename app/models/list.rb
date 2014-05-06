class List < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :movies

	validates_length_of :name, maximum: 50, allow_nil: false
	validates_length_of :description, maximum: 500, allow_nil: true
	validates_presence_of :user_id
end
