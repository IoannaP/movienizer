class Review < ActiveRecord::Base
	belongs_to :movie
	belongs_to :user

	validates_presence_of :movie_id, :user_id
	validates_uniqueness_of :movie_id, scope: :user_id
	validates_inclusion_of :rating, in: 1..10
	validates_length_of :comment, maximum: 1000, allow_nil: true
end
