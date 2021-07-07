require_relative '../application_service'


module Account
  class IsAuth < ApplicationService

    def initialize(token)
      if token.class != String
        raise "token must be str"
      end

      @token = token
    end

    def call
      u = User.find_by(token: @token)
      u ? u : false
    end
  end
end

