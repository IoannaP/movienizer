require 'spec_helper'

describe BoxOfficeMovie do
	before do 
		@box_office_movie = BoxOfficeMovie.new(rotten_tomatoes_id: "1234", title: "Sample Movie")
	end

	subject { @box_office_movie }

	it { should respond_to :rotten_tomatoes_id }
	it { should respond_to :title }
	it { should be_valid }

	describe "when rottentomatoes id is nil" do
		before { @box_office_movie.rotten_tomatoes_id = nil }
		it { should_not be_valid }
	end

	describe "when rottentomatoes id is blank" do
		before { @box_office_movie.rotten_tomatoes_id = "" }
		it { should_not be_valid }
	end

	describe "when title is nil" do
		before { @box_office_movie.title = nil }
		it { should_not be_valid }
	end

	describe "when title is blank" do
		before { @box_office_movie.title = "" }
		it { should_not be_valid }
	end
end
