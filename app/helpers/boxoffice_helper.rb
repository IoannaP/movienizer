require 'open-uri'
require 'json'

module BoxofficeHelper
  
  # return Box Office Movies from database
  # the Box Office is refreshed if last update
  # was made more that 24 hours ago
  def box_office_movies

  	# get first movie from table to check his
  	# created_at date
	last = BoxOfficeMovie.first

	# if database is empty or last update was made more
	# than 24 hours ago, movies are updated
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

  private

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

end
