class List < ActiveRecord::Base
	belongs_to :user
	has_many :list_movie_pairs
	has_many :movies, :through => :list_movie_pairs

	validates_length_of :name, maximum: 50
	validates_length_of :description, maximum: 500
	validates_presence_of :name, :user_id
	validates_inclusion_of :private, in: [true, false]
	validate :validate_movies_count

	# accepts_nested_attributes_for :list_movie_pairs, :allow_destroy => true
	# accepts_nested_attributes_for :movies, :allow_destroy => true

private
	def validate_movies_count
		errors.add(:list_movie_pairs, "too many") if list_movie_pairs.size > 50
	end
end
