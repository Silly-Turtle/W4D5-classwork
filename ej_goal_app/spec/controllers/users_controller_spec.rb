require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "brings up the sign up page" do
      # allow (:user).to receive(:logged_in?).and_return true
      get (:new)
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid paramters" do
    let(:valid_params) { { user: { name: "asdf", password: "string" } } }
      it "redirect when parameters are valid" do
      post :create, params: valid_params
        expect(response).to have_http_status(302)
      end
    end

    context "w/o valid parameters" do
      let(:invalid_params) { { user: { name: "asdf", password: "" } } }
      before :each do
        post :create, params: invalid_params
      end
      it "send error when parameters are invalid" do
        expect(flash[:errors]).to be_present
      end

      it "renders sign up page when parameters are invalid" do
        expect(response).to render_template :new
      end
    end
  end


end
