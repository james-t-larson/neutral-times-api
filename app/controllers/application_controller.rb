class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from RailsParam::InvalidParameterError do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  # @note This method is used to enforce consistency in the JSON API responses.
  def generic_render(data: {}, message: nil, code: nil, status: nil, **custom_params)
    render json: custom_params.merge({
      message: message || "Success",
      code: code || 0,
      data: data
    }), status: status || :ok
  end

  def record_not_found
    generic_render(message: "Record not found", status: :not_found)
  end

  allow_browser versions: :modern
end
