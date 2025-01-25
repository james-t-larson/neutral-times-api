class Admin::GenerateArticlesController < ApplicationController
  def create
    Services::Articles::GenerationService.generate()
    generic_render(message: "Initiated Generation Service")
  end
end
