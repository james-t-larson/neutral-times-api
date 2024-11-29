class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from RailsParam::InvalidParameterError do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  # Renders a standardized JSON response for the application.
  #
  # @param data [Hash] The main data payload to include in the response. Defaults to an empty hash.
  # @param message [String, nil] An optional message describing the result or status. Defaults to nil.
  # @param code [Integer] An application-specific status code for the response. Defaults to 0.
  # @param status [Symbol] The HTTP status for the response (e.g., :ok, :not_found, :unprocessable_entity). Defaults to :ok.
  #
  # @example Successful response with data
  #   generic_render(data: { user: { id: 1, name: "John Doe" } }, message: "Success", code: 100, status: :ok)
  #
  # @example Error response with a message
  #   generic_render(message: "Invalid parameters", code: 422, status: :unprocessable_entity)
  #
  # @note This method is used to enforce consistency in the JSON API responses.
  def generic_render(data: {}, message: "Success", code: 0, status: :ok)
    render json: {
      message: message,
      code: code,
      data: data
    }, status: status
  end

  def record_not_found
    generic_render(message: "Record not found", status: :not_found)
  end

  allow_browser versions: :modern
end
