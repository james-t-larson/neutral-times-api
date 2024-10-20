class StoriesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @story = Story.find(params[:id])
    render json: @story.as_json(include: :contents)
  end

  def index
    stories = Story.includes(:contents).all
    render json: stories.as_json(include: :contents)
  end

  private

  def record_not_found
    render json: { error: "Story not found" }, status: :not_found
  end
end
