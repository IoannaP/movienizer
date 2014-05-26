require 'open-uri'
require 'json'

class ListsController < ApplicationController	
  before_action :authenticate_user!

  helper_method :list
  helper_method :user_lists

  def index
    @user = User.find_by_username(params[:username])
    @lists = @user.lists.page(params[:page]).per(10).order('created_at DESC')
    @public_lists_count = @lists.where(private: false).count
  end

  def new
    @list = current_user.lists.new
  end

  def create
  	@list = current_user.lists.new(list_params)

  	if @list.save
<<<<<<< HEAD
      redirect_to user_list_list_movie_pairs_path(current_user.username, list)
=======
	    #TODO: Make this flash directly on user_lists_path
	    flash[:success] = "#{@list.name} has been successfully created !"
      redirect_to user_lists_path(current_user.username)
>>>>>>> c4cb08aea2165d152b2e570d88be72f473ab679a
   	else
	    render :new
  	end
  end

  def edit
  end

  def update
  	list.update(list_params)

    if @list.save
      redirect_to user_lists_path(current_user.username)
    else
      render :edit
    end
  end

  def show
    @exists = !(List.where(id: params[:id]).empty?)

    if @exists
      @user = User.find_by_username(params[:username])
      @movies = list.movies.page(params[:page]).per(20)
    end
  end

  def destroy
    deleted_list = current_user.lists.find(params[:id])
    deleted_list.destroy
    redirect_to user_lists_path(current_user.username)
  end

  def remove_movie
    movie = Movie.find(params[:movie_id])
    if movie
      list.movies.delete(movie)
    end
      redirect_to user_list_path(current_user.username, params[:id])
  end

  def add_movies
    @pair = list.list_movie_pairs.new
  end

  def submit_movies
    @list = current_user.lists.find(params[:id])
    @pair = @list.list_movie_pairs.new(pair_params)
    
    remote_id = @pair.movie_id
    unless Movie.find_by_rotten_tomatoes_id(remote_id)
        Movie.create(title: movie_title(remote_id), year: movie_year(remote_id), \
          rotten_tomatoes_id: remote_id, thumbnail_poster_link: movie_thumbnail(remote_id), \
          detailed_poster_link: movie_poster(remote_id))
    end

    @pair.movie_id = Movie.find_by_rotten_tomatoes_id(remote_id).id

    if @pair.save      
      redirect_to user_list_path(current_user.username, @list)
    else
      render :add_movies
    end
  end

private

  def movie_request(id)
    apilink = 'http://api.rottentomatoes.com/api/public/v1.0/'
    apikey = 'haak3yvy8dsw4gfxu8vprvnv'
    @link = apilink + 'movies/' + id.to_s + '.json?apikey=' + apikey
    search_string = URI.parse(@link).read
  end

  def movie_query(json_string)
    parsed_json = JSON.parse(json_string)
  end

  def movie_title(remote_id)
    search_results = movie_request(remote_id)
    @movie = movie_query(search_results)
    @movie['title']
  end

  def movie_year(remote_id)
    # search_results = movie_request(remote_id)
    # movie = movie_query(search_results)
    @movie['year']
  end

  def movie_thumbnail(remote_id)
    @movie['posters']['thumbnail']
  end

  def movie_poster(remote_id)
    @movie['posters']['detailed']
  end

  def user_lists
    user_lists = User.find_by_username(params[:username]).lists
  end

  def list
    @list ||= user_lists.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :description, :private)#,
      # list_movie_pairs_attributes: [:id, :list_id, :movie_id, :_destroy],
      # movies_attributes: [:id, :title, :_destroy])
  end

  def pair_params
    params.require(:list_movie_pair).permit(:list_id, :movie_id)
  end
end
