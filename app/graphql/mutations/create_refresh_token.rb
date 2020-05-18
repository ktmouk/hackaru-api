# frozen_string_literal: true

module Mutations
  class CreateRefreshToken < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :refresh_token, Types::RefreshTokenType, null: false

    def resolve(email:, password:)
      user = authenticate_user!(email, password)
      refresh_token, raw = RefreshToken.issue(user)
      {
        refresh_token: {
          client_id: refresh_token.client_id,
          token: raw
        }
      }
    end

    private

    def authenticate_user!(email, password)
      user = User.find_by(email: email)
      raise_error :sign_in_failed unless user&.authenticate(password)
      user
    end
  end
end
