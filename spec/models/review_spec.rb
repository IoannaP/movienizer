require 'spec_helper'

describe Review do
  before do
  	@review = Review.new(rating: 10, user_id: 1, movie_id: 1)
  end

  subject { @review }

  it { should respond_to :rating }
  it { should respond_to :user_id }
  it { should respond_to :movie_id }
  it { should be_valid }

  describe "when rating is not present" do
  	before { @review.rating = nil }
  	it { should_not be_valid }
  end

  describe "when comment is not present" do
  	before { @review.comment = nil }
  	it { should be_valid }
  end

  describe "when rating is less than 1" do
  	before { @review.rating = 0 }
  	it { should_not be_valid }
  end

  describe "when rating is higher than 10" do
  	before { @review.rating = 11 }
  	it { should_not be_valid }
  end

  describe "when comment is longer than 1000 characters" do
  	before { @review.comment = 'a' * 1001 }
  	it { should_not be_valid }
  end

  describe "when movie id is not present" do
  	before { @review.movie_id = nil }
  	it { should_not be_valid }
  end

  describe "when user id is not present" do
  	before { @review.user_id = nil }
  	it { should_not be_valid }
  end
end
