class Admin::GenerateArticlesController < ApplicationController
  def create
    Articles::Generate.generate()
    generic_render(message: "Initiated Generation Service")
  end
end
