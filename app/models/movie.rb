class Movie < ActiveRecord::Base
	has_and_belongs_to_many :lists
	has_many :reviews

	validates_presence_of :rotten_tomatoes_id, :title
end
