require 'spec_helper'

describe SearchesController do
  let(:user) { create(:user) }
  before { sign_in(user) }
  describe "GET 'index'" do
    it "returns http success" do
      get 'index', column: :diets
      response.should be_success
    end
  end

end