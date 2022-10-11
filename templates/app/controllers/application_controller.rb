# frozen_string_literal: true

class ApplicationController < ActionController::API
  def health
    render json: { message: 'public' }
  end
end
