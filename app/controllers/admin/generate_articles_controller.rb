class Admin::GenerateArticlesController < ApplicationController
  def create
    Articles::Generate.perform()
    generic_render(message: "Initiated Generation Service")
  end
end
