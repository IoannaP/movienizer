require 'open-uri'
require 'json'
require 'nokogiri'

class MoviesController < ApplicationController

	def show
		json_string = movie_request(params[:movie_id])
		@movie = movie_query(json_string)

		@youtube_trailer_id = trailer_request(@movie['title'], @movie['year'].to_s)

		movie_id = Movie.select("id").where("rotten_tomatoes_id = ?", params[:movie_id])
		#@reviews = current_user.reviews.where("movie_id = ?", movie_id)
		#@reviews = Review.select("comment").where("movie_id = ? and user_id = ?", movie_id, current_user.id)
	end

	private

	#return the video id on youtube
	# => It use YouTube api and suppose that
	# => first result is actually the best result
	# TODO => Refactor this code when we have time
	def trailer_request( title , year )

	  # create the query string for the movie
	  query = title.gsub(' ', '+') + '+' + year;

	  # the basic link for the YouTube API
	  youtube_api_link = 'https://gdata.youtube.com/feeds/api/videos' 
  	  
  	  # create the link with all the above informations
  	  youtube_link = youtube_api_link + '?q=' + query;

  	  # takes the XML using a HTTP request on the API
 	  trailer_XML = URI.parse(youtube_link)
	
	  # parse the XML string
	  doc = Nokogiri::XML(open(youtube_link))
	  
	  # get the video embeded link on youtube
	  doc = doc.xpath('//xmlns:feed/xmlns:entry/xmlns:id')[0].to_s;
	  doc.gsub('<id>http://gdata.youtube.com/feeds/api/videos/', '').gsub('</id>', '')
	end

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
