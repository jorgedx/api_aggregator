class UserStatusesController < ApplicationController

  include ApiErrorHandler

  def show
    user_status = UserStatusAggregatorService.new(show_params[:id]).call
    render json: UserStatusPresenter.new(user_status).as_json, status: :ok
  end

  private

  def show_params
    params.permit(:id)
  end
end