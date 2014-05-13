require 'spec_helper'

describe List do
  before do
  	@list = List.new(id: 1, name: "Sample List", user_id: 1, private: true)
  end

  subject { @list }

  it { should respond_to :name }
  it { should respond_to :user_id }
  it { should be_valid }

  describe "when name is nil" do
  	before { @list.name = nil }
  	it { should_not be_valid }
  end

  describe "when name is blank" do
    before { @list.name = "" }
    it { should_not be_valid }
  end

  describe "when name is longer than 50 characters" do
  	before { @list.name = 'a' * 51 }
  	it { should_not be_valid }
  end

  describe "when description is nil" do
  	before { @list.description = nil }
  	it { should be_valid }
  end

  describe "when description is blank" do
    before { @list.description = "" }
    it { should be_valid }
  end

  describe "when description is longer than 500" do
  	before { @list.description = 'a' * 501 }
  	it { should_not be_valid }
  end

  describe "when user id is nil" do
  	before { @list.user_id = nil }
  	it { should_not be_valid }
  end

  describe "when the privacy attribute is nil" do
    before { @list.private = nil }
    it { should_not be_valid }
  end

  describe "when the list has more than 50 movies" do
    before do
      list_movie_pairs = []
      51.times do |i|
        list_movie_pairs << ListMoviePair.new(list_id: 1, movie_id: i)
      end
      @list.list_movie_pairs = list_movie_pairs
    end
    it { should_not be_valid }
  end
end
