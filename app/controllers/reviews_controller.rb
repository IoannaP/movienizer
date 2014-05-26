class ReviewsController < ApplicationController
  before_action :authenticate_user!

  helper_method :review
  helper_method :user_reviews
  helper_method :thumbnail_poster
  helper_method :detailed_poster
  helper_method :movie_title

  def index
    @user = User.find_by_username(params[:username])
    @reviews = @user.reviews.page(params[:page]).per(5).order('created_at DESC')
    @public_reviews_count = @reviews.where(private: false).count
  end
  
  def new
  	@review = current_user.reviews.new
  	@review.movie_id = params[:id]
    @rating = movie_rating(params[:id])
  end

  def create
  	@review = current_user.reviews.new(review_params)

  	if @review.save
	  #TODO: Make this flash directly on user_lists_path
	  #flash[:success] = @list[:name] + " has been successfully created !"
      redirect_to user_reviews_path(current_user.username)
   	else
	  redirect_to new_user_review_path(current_user.username, @review.movie_id)
  	end
  end

  def edit
    @movie = Movie.find(params[:id])
    @rating = movie_rating(params[:id])
  end

  def update
    @review = review
    @review.update(review_params)

    if @review.save
      redirect_to user_reviews_path(current_user.username)
    else
      render :edit
    end
  end

  def show
    @user = User.find_by_username(params[:username])
  end

  def destroy
    deleted_review = current_user.reviews.find_by_movie_id(params[:id])
    deleted_review.destroy
    redirect_to user_reviews_path(current_user.username)
  end

  private

  def movie_rating(movie_id)
    reviews = Review.where(:movie_id => movie_id)
    rating = 0
    reviews.each do |review|
      rating = rating + review.rating
    end
    rating = rating / reviews.length
  end

  def current_user_reviews
    current_user.reviews
  end

  def review
    current_user_reviews.find(params[:id])
  end

  def thumbnail_poster
  	@thumbnail_p ||= Movie.find(params[:id]).thumbnail_poster_link
  end

  def detailed_poster
  	@detailed_p ||= Movie.find(params[:id]).detailed_poster_link
  end

  def movie_title
  	@movie_t ||= Movie.find(params[:id]).title
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :private, :movie_id)
  end

end
