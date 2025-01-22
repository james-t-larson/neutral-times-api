require "rails_helper"

RSpec.describe V2::CategoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v2/categories").to route_to("v2/categories#index")
    end

    it "routes to #show" do
      expect(get: "/v2/categories/1").to route_to("v2/categories#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v2/categories").to route_to("v2/categories#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v2/categories/1").to route_to("v2/categories#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v2/categories/1").to route_to("v2/categories#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v2/categories/1").to route_to("v2/categories#destroy", id: "1")
    end
  end
end
