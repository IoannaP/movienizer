require 'spec_helper'

describe Movie do
	before do 
		@movie = Movie.new(rotten_tomatoes_id: "1234", title: "Sample Movie")
	end

	subject { @movie }

	it { should respond_to :rotten_tomatoes_id }
	it { should respond_to :title }
	it { should be_valid }

	describe "when rottentomatoes id is nil" do
		before { @movie.rotten_tomatoes_id = nil }
		it { should_not be_valid }
	end

	describe "when rottentomatoes id is blank" do
		before { @movie.rotten_tomatoes_id = "" }
		it { should_not be_valid }
	end

	describe "when title is nil" do
		before { @movie.title = nil }
		it { should_not be_valid }
	end

	describe "when title is blank" do
		before { @movie.title = "" }
		it { should_not be_valid }
	end	
end