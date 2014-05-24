require 'open-uri'
require 'json'

class SearchesController < ApplicationController
	
  def search

	if params[:q]
	  @search_res = movies_request(params[:q])
	  @movies_part = movies_query(@search_res)
	end
  
  end

  private

  # return the jSon string returned from the API for all the movies
  # that correspond with the name given by the parameter 'param'
  def movies_request( param )

    # the basic link for the API (without any query specified properties)
    apilink = 'http://api.rottentomatoes.com/api/public/v1.0/' 
    # the key for the API
	# TODO: change api key when this is ready
	apikey = 'haak3yvy8dsw4gfxu8vprvnv'
	# number of the movies returned by the query
	apipagelimit = 'page_limit=10'

	# replace all whitespaces from the 'param' string with character '+'
	# this is required by the standard of the API query
	param.gsub!(/\s/,'+')

	# create the link with all of the above informations
	@link = apilink + 'movies.json?apikey=' + apikey + '&q=' + param + '&' + apipagelimit

	# takes the jSon string using a HTTP request on the API
	search_string = URI.parse(@link).read

  end

  # return the jSon string returned by the API
  # for a particular movie specified by 'id'
  def movie_request( id )

	# the basic link for the API (without any query specified properties)
	apilink = 'http://api.rottentomatoes.com/api/public/v1.0/'
	# the key for the API
	# TODO: change api key when this is ready
	apikey = 'haak3yvy8dsw4gfxu8vprvnv'

	# create the link with all of the above informations
	@link = apilink + 'movies/' + id.to_s + '.json?apikey=' + apikey

	# takes the jSon string using a HTTP request on the API
	search_string = URI.parse(@link).read

  end

  # return an array with informations about all movies
  # that are contained in the jSon string
  def movies_query( json_string )

	# this thing remains in romanian because I can't explain very well in english
	# TODO: translate this in english when you have time
	# se parseaza json-ul intr-o structura recursiva gen
	# hash-uri (din ruby) de hash-uri (sau array-uri, in
	# in functie de configuratia json-ului in acel moment)
	parsed_json = JSON.parse(json_string)

	# declare new array for the movies
	movies = Array.new

	# takes every movie from the 'parsed_json' and
	# insert it in the array declared above
	parsed_json['movies'].each do |movie|
	  movies.push movie
	end

	# return the array with movies
	movies
  end

  # return a recursive structure (somthing like a hash of hashes)
  # this structure keep informations about the movies
  def movie_query( json_string )

	# parse the jSon string in a recursive structure
	# return this structure
	parsed_json = JSON.parse(json_string)

  end

end
