# frozen_string_literal: true

module Mutations
  class CreateAccessToken < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :csrf_token, :string, null: true

    def resolve(email:, password:)
      user = authenticate_user!(email, password)
      tokens = build_jwt_session(user).login
      set_access_cookie(tokens[:access])
      { csrf_token: tokens[:csrf] }
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

    def authenticate_user!(email, password)
      user = User.find_by(email: email)
      raise_error :sign_in_failed unless user&.authenticate(password)
      user
    end
  end
end
