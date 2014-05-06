class ListMoviePair < ActiveRecord::Base
	belongs_to :list
	belongs_to :movie

	validates_presence_of :list_id, :movie_id
	validates_uniqueness_of :movie_id, scope: :list_id
end
