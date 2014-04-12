require 'open-uri'
require 'json'

class MoviesController < ApplicationController

	def show
		json_string = movie_request(params[:movie_id])
		@movie = movie_query(json_string)
		@reviews = Movie.select("review").where("movie_id = ?",params[:movie_id])
	end

	private

	#return the jSon string returned by the API
	#for a particular movie specified by 'id'
	def movie_request( id )

		#the basic link for the API (without any query specified properties)
		apilink = 'http://api.rottentomatoes.com/api/public/v1.0/'
		#the key for the API
		#TODO: change api key when this is ready
		apikey = 'haak3yvy8dsw4gfxu8vprvnv'

		#create the link with all of the above informations
		@link = apilink + 'movies/' + id.to_s + '.json?apikey=' + apikey

		#takes the jSon string using a HTTP request on the API
		search_string = URI.parse(@link).read

	end

	#return a recursive structure (somthing like a hash of hashes)
	#this structure keep informations about the movies
	def movie_query( json_string )

		#parse the jSon string in a recursive structure
		#return this structure
		parsed_json = JSON.parse(json_string)

	end

end
