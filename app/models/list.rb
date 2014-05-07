class List < ActiveRecord::Base
	belongs_to :user
	has_many :list_movie_pairs
	has_many :movies, :through => :list_movie_pairs

	validates_length_of :name, maximum: 50
	validates_length_of :description, maximum: 500
	validates_presence_of :name, :user_id
	validates_inclusion_of :private, in: [true, false]
end
