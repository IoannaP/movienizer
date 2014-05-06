require 'spec_helper'

describe ListMoviePair do
  before do
  	@list_movie_pair = ListMoviePair.new(list_id: 1, movie_id: 1)
  end

  subject { @list_movie_pair }

  it { should respond_to :list_id }
  it { should respond_to :movie_id }
  it { should be_valid }

  describe "when list id is nil" do
  	before { @list_movie_pair.list_id = nil }
  	it { should_not be_valid }
  end
  
  describe "when movie id is nil" do
  	before { @list_movie_pair.movie_id = nil }
  	it { should_not be_valid }
  end

  describe "when the movie is already in the list" do
  	before do
  		list_movie_pair_dup = @list_movie_pair.dup
  		list_movie_pair_dup.save
  	end

  	it { should_not be_valid }	
  end
end
