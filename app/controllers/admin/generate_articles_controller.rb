class Admin::GenerateArticlesController < ApplicationController
  def create
    limit = params[:limit].to_i.positive? ? params[:limit].to_i : nil
    Articles::Generate.perform(limit)
    generic_render(message: "Initiated Generation Service")
  end
end
