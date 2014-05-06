require 'spec_helper'

describe List do
  before do
  	@list = List.new(name: "Sample List", user_id: 1)
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
end
