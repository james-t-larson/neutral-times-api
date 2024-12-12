
require 'rails_helper'

RSpec.describe Admin::PromptsController, type: :controller do
  controller(Admin::PromptsController) { }

  let(:current_prompt) { create(:prompt) } # Factory for Prompt model
  let(:version1) { double('Version', id: 1, object: "---\ntext: Version 1 text\n") }
  let(:version2) { double('Version', id: 2, object: "---\ntext: Version 2 text\n") }

  before do
    allow(Prompt).to receive(:current).and_return(current_prompt)
    allow(current_prompt).to receive(:versions).and_return([ version1, version2 ])
  end

  describe "GET #index" do
    it "renders the current prompt" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(current_prompt.to_json)
    end
  end

  describe "POST #update" do
    it "updates the current prompt text and renders a success message" do
      post :update, params: { text: "Updated Prompt Text" }

      expect(response).to have_http_status(:ok)
      expect(current_prompt.reload.text).to eq("Updated Prompt Text")
      expect(JSON.parse(response.body)["message"]).to eq("Prompt has been updated")
    end
  end

  describe "GET #versions" do
    it "renders all versions of the current prompt" do
      get :versions
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(version1.to_json)
      expect(response.body).to include(version2.to_json)
    end
  end

  describe "GET #version" do
    it "renders the specific version of the current prompt" do
      allow(current_prompt.versions).to receive(:find).with("1").and_return(version1)

      get :version, params: { id: 1 }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(version1.object.to_json)
    end
  end

  describe "POST #restore" do
    it "restores a specific version and saves the restored instance" do
      restored_instance = double('Prompt', save!: true)
      allow(version1).to receive(:reify).and_return(restored_instance)
      allow(current_prompt.versions).to receive(:find).with("1").and_return(version1)

      post :restore, params: { id: 1 }

      expect(restored_instance).to have_received(:save!)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("restored_instance")
    end
  end

  describe "POST #diff" do
    it "renders the diff between two versions" do
      allow(version1).to receive(:object).and_return("---\ntext: Version 1 text\n")
      allow(version2).to receive(:object).and_return("---\ntext: Version 2 text\n")
      allow(current_prompt.versions).to receive(:find).with("1").and_return(version1)
      allow(current_prompt.versions).to receive(:find).with("2").and_return(version2)

      post :diff, params: { version_1: 1, version_2: 2 }

      diff = Diffy::Diff.new("Version 1 text", "Version 2 text")
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(diff.to_s)
    end
  end
end
