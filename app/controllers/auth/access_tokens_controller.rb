# frozen_string_literal: true

module Auth
  class AccessTokensController < ApplicationController
    def create
      user = authenticate_user!
      tokens = build_jwt_session(user).login
      set_access_cookie(tokens[:access])
      render json: { csrf_token: tokens[:csrf] }
    end

    private

    def set_access_cookie(access_token)
      response.set_cookie(
        JWTSessions.access_cookie,
        value: access_token,
        httponly: true,
        secure: Rails.env.production?
      )
    end

    def build_jwt_session(user)
      JWTSessions::Session.new(
        payload: { user_id: user.id },
        refresh_by_access_allowed: true
      )
    end

    def authenticate_user!
      user = User.find_by(email: user_params[:email])
      render status: 401 unless user&.authenticate(user_params[:password])
      user
    end

    def user_params
      params.require(:user).permit(
        :email,
        :password
      )
    end
  end
end
