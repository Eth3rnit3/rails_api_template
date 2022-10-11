# frozen_string_literal: true

module Api
  class ApplicationController < ::ApplicationController
    include Pundit::Authorization
    before_action :authenticate_user!

    def health
      render json: { message: 'private' }
    end
  end
end
