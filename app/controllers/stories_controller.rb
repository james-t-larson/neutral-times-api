class StoriesController < ApplicationController
  def index
    if params[:id]
      story = Story.includes(:contents).find_by(id: params[:id])
      if story
        render json: story.as_json(include: :contents)
      else
        render json: { error: 'Story not found' }, status: :not_found
      end
    else
      stories = Story.includes(:contents).all
      render json: stories.as_json(include: :contents)
    end
  end
end

