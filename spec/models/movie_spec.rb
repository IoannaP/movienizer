require 'spec_helper'

describe Movie do
	before do 
		@movie = Movie.new(rotten_tomatoes_id: "1234", title: "Sample Movie")
	end

	subject { @movie }

	it { should respond_to :rotten_tomatoes_id }
	it { should respond_to :title }
	it { should be_valid }

	describe "when rottentomatoes id is not present" do
		before { @movie.rotten_tomatoes_id = nil }
		it { should_not be_valid }
	end

	describe "when title is not present" do
		before { @movie.title = nil }
		it { should_not be_valid }
	end
end