class Movie < ActiveRecord::Base
	has_many :list_movie_pairs
	has_many :lists, :through => :list_movie_pairs
	has_many :reviews

	validates_presence_of :rotten_tomatoes_id, :title
end
