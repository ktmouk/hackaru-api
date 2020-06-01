# frozen_string_literal: true

module Auth
  class AccessTokensController < ApplicationController
    include JWTSessions::RailsAuthorization
    rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

    before_action :authorize_refresh_by_access_cookie!, only: :update

    def create
      user = authenticate_user!
      tokens = build_session({ user_id: user.id }).login
      set_access_cookie(tokens[:access])
      render json: { csrf_token: tokens[:csrf] }
    end

    def update
      tokens = build_session(claimless_payload).refresh_by_access_payload
      set_access_cookie(tokens[:access])
      render json: { csrf_token: tokens[:csrf] }
    end

    private

    def authenticate_user!
      user = User.find_by(email: user_params[:email])
      not_authorized unless user&.authenticate(user_params[:password])
      user
    end

    def not_authorized
      render status: :unauthorized
    end

    def set_access_cookie(access_token)
      response.set_cookie(
        JWTSessions.access_cookie,
        value: access_token,
        httponly: true,
        secure: Rails.env.production?
      )
    end

    def build_session(payload)
      JWTSessions::Session.new(
        payload: payload,
        refresh_by_access_allowed: true
      )
    end

    def user_params
      params.require(:user).permit(
        :email,
        :password
      )
    end
  end
end
