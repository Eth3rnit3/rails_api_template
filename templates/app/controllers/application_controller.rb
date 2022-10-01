# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def health
    render json: { status: 'public' }
  end
end
