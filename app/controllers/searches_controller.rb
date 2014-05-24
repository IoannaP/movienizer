require 'open-uri'
require 'json'

class SearchesController < ApplicationController
	
	def search
		@movies_box_office = boxoffice_movies

		if params[:q]
			@search_res = movies_request(params[:q])
			@movies_part = movies_query(@search_res)
		end

		# respond_to do |format|
		# 	format.html { redirect_to searches_url }
		# 	format.js
		# end
	end

	private

	#return the jSon string returned from the API for all the movies
	#that correspond with the name given by the parameter 'param'
	def movies_request( param )

		#the basic link for the API (without any query specified properties)
		apilink = 'http://api.rottentomatoes.com/api/public/v1.0/' 
		#the key for the API
		#TODO: change api key when this is ready
		apikey = 'haak3yvy8dsw4gfxu8vprvnv'
		#number of the movies returned by the query
		apipagelimit = 'page_limit=10'

		#replace all whitespaces from the 'param' string with character '+'
		#this is required by the standard of the API query
		param.gsub!(/\s/,'+')

		#create the link with all of the above informations
		@link = apilink + 'movies.json?apikey=' + apikey + '&q=' + param + '&' + apipagelimit

		#takes the jSon string using a HTTP request on the API
		search_string = URI.parse(@link).read

	end

  # return Box Office Movies from database
  # the Box Office is refreshed if last update
  # was made more that 24 hours ago
  def boxoffice_movies

  	# get first movie from table to check his
  	# created_at date
	last = BoxOfficeMovie.first

	# if database is empty or last update was more that
	# 24 hours ago, movies are updated
	if last == nil || last.created_at < DateTime.now - 1.day

  	  # delete all movies from Box Office Table
	  BoxOfficeMovie.delete_all

	  # get jSon string from Rotten Tomatoes API
	  search_string = boxoffice_request

	  # parse jSon string
  	  movies_box_office = movies_query(search_string)

  	  # insert every movie in database
  	  movies_box_office.each do |movie|

  	  	# it is checked if the movie have thumbnail_posters
  	  	# some movies on the website don't have this poster
  	  	thumbnail_poster = nil
  	  	if movie['posters'] && movie['posters']['thumbnail']
  	  	  thumbnail_poster = movie['posters']['thumbnail']
  	  	end

  	  	# insert movie in database
  	  	box_office_movie = BoxOfficeMovie.new(
  	  			:title => movie['title'], 
  	            :rotten_tomatoes_id => movie['id'],
  	            :thumbnail_poster_link => thumbnail_poster)

  	    box_office_movie.save

  	  end
  	
  	end

  	BoxOfficeMovie.all

  end

  # return the jSon string returned by the API
  # for a Box Office request
  def boxoffice_request

    # the basic link for the API (without any query specified properties)
    apilink = 'http://api.rottentomatoes.com/api/public/v1.0/'
    # the key for the API
    # TODO: change api key when this is ready
    apikey = 'haak3yvy8dsw4gfxu8vprvnv'
    # number of the movies returned by the query
    apipagelimit = 'limit=10'

    # create the link with all of the above informations
    @link = apilink + 'lists/movies/box_office.json?apikey=' + apikey + '&' + apipagelimit

    # takes the jSon string using a HTTP request on the API
    search_string = URI.parse(@link).read

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

	#return an array with informations about all movies
	#that are contained in the jSon string
	def movies_query( json_string )

		#this thing remains in romanian because I can't explain very well in english
		#TODO: translate this in english when you have time
		#se parseaza json-ul intr-o structura recursiva gen
		#hash-uri (din ruby) de hash-uri (sau array-uri, in
		#in functie de configuratia json-ului in acel moment)
		parsed_json = JSON.parse(json_string)

		#declare new array for the movies
		movies = Array.new

		#takes every movie from the 'parsed_json' and
		#insert it in the array declared above
		parsed_json['movies'].each do |movie|
			movies.push movie
		end

		#return the array with movies
		movies
	end

	#return a recursive structure (somthing like a hash of hashes)
	#this structure keep informations about the movies
	def movie_query( json_string )

		#parse the jSon string in a recursive structure
		#return this structure
		parsed_json = JSON.parse(json_string)

	end

end
