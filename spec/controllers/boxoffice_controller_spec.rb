require 'spec_helper'

describe BoxofficeController do

  describe "GET 'partial'" do
    it "returns http success" do
      get 'partial'
      expect(response).to be_success
    end
  end

end
