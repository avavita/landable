module Landable
  class ApiController < ApplicationController
    before_filter :require_author!

    rescue_from ActiveRecord::RecordNotFound do |ex|
      head 404
    end

    rescue_from ActiveRecord::RecordInvalid do |ex|
      render json: { errors: ex.record.errors }, status: :unprocessable_entity
    end

    rescue_from ActionController::UnknownFormat do |ex|
      head :not_acceptable
    end

    protected

    def require_author!
      head :unauthorized if current_author.nil?
    end

    def current_author
      return @current_author if @current_author
      authenticate_with_http_basic do |username, token|
        @current_author = Author.authenticate!(username, token)
      end
    end
  end
end