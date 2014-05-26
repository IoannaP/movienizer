require 'open-uri'
require 'json'
require 'nokogiri'

class MoviesController < ApplicationController

  helper_method :rotten_tomatoes_movie_id
  helper_method :movie_title
  helper_method :thumbnail_poster
  helper_method :detailed_poster

  def show
	json_string = movie_request(params[:movie_id])
	@movie = movie_query(json_string)

	@youtube_trailer_id = trailer_request(@movie['title'], @movie['year'].to_s)

	# add movie to database if it's not already
	if Movie.exists?(:rotten_tomatoes_id => params[:movie_id]) == false
	  movie_title = @movie['title']
	  
	  new_movie = Movie.new(:rotten_tomatoes_id => params[:movie_id], :title => movie_title, :thumbnail_poster_link => thumbnail_poster, :detailed_poster_link => detailed_poster)
	  
	  new_movie.save
	end
	
	@existent_movie = Movie.where(:rotten_tomatoes_id => params[:movie_id]).first

	@reviews = Review.where(:movie_id => @existent_movie.id)

	if user_signed_in?
	  @current_user_review = @reviews.find_by_user_id(current_user.id)
	else
	  @current_user_review = nil;
	end

	@public_reviews_count = 0
	@reviews.each do |review|
	  if review.private == false and (user_signed_in? == false or review.user_id != current_user.id)
	  	@public_reviews_count = @public_reviews_count + 1
	  end
	end
  end

  private

  # return the video id on youtube
  # => It use YouTube api and suppose that
  # => first result is actually the best result
  # TODO => Refactor this code when we have time
  def trailer_request( title , year )
    # create the query string for movie
    query = title.gsub(' ', '+') + '+' + year;
	# the basic link for the YouTube API
	youtube_api_link = 'https://gdata.youtube.com/feeds/api/videos' 
  	# create the link with all the above informations
  	youtube_link = youtube_api_link + '?q=' + query;
  	# takes and parse the XML using a HTTP request on the API
	doc = Nokogiri::XML(open(youtube_link))
	# get the video embeded link on youtube
	doc = doc.xpath('//xmlns:feed/xmlns:entry/xmlns:id')[0].to_s;
	doc.gsub('<id>http://gdata.youtube.com/feeds/api/videos/', '').gsub('</id>', '')
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

  # return a recursive structure (somthing like a hash of hashes)
  # this structure keep informations about the movies
  def movie_query( json_string )
	# parse the jSon string in a recursive structure
	# return this structure
	parsed_json = JSON.parse(json_string)
  end

  def movie_title
  	@movie['title']
  end

  def rotten_tomatoes_movie_id
  	@movie['id']
  end

  def thumbnail_poster
	if @movie['posters'] and @movie['posters']['thumbnail']
	  thumbnail = @movie['posters']['thumbnail']
	else
		nil
	end
  end

  def detailed_poster
	if @movie['posters'] and @movie['posters']['detailed']
	  thumbnail = @movie['posters']['detailed']
	else
	  nil
	end
  end

  def database_movie_id

  end

end
