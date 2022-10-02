# frozen_string_literal: true

module Api
  class ApplicationController < ::ApplicationController
    include Pundit::Authorization
    before_action :authenticate_user!

    def health
      render json: { status: 'private' }
    end
  end
end
