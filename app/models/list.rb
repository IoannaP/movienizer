class List < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :movies

	validates_length_of :name, maximum: 50
	validates_length_of :description, maximum: 500
	validates_presence_of :name, :user_id
end
