module ApiErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActionController::BadRequest, ArgumentError, with: :render_bad_request
  end

  private

  def render_not_found
    render json: { error: "Not found" }, status: :not_found
  end

  def render_bad_request
    render json: { error: "Bad Request" }, status: :bad_request
  end
end