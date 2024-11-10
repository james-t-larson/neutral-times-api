class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from RailsParam::InvalidParameterError do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

  allow_browser versions: :modern
end
