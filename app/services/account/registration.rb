require_relative '../application_service'


module Account
  class Registration < ApplicationService
    RETURNS = [
      SUCCESS = :success,
      PASSWORD_MISMATCH = :password_mismatch,
      PASSWORD_SHORT = :password_short,
      LOGIN_BUSY = :login_busy,
      LOGIN_SHORT = :login_short,
      FAILURE = :failure
    ]

    def initialize(login, password, password2)
      if login.class != String || password.class != String || password2.class != String
        raise "all params must be str"
      end

      @login = login
      @password = password
      @password2 = password2
    end

    def call
      if @password != @password2
        return PASSWORD_MISMATCH
      end

      if @password.length < 8
        return PASSWORD_SHORT
      end

      if @login.length < 1
        return LOGIN_SHORT
      end

      user = User.where(name: @login).first
      if user
        return LOGIN_BUSY
      end

      u = User.new(name: @login, password: @password, password_confirmation: @password2)
      if u.save
        SUCCESS
      else
        FAILURE
      end
    end
  end
end
