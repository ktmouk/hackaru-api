# frozen_string_literal: true

module Mutations
  class CreateAccessToken < BaseMutation
    argument :client_id, String, required: true
    argument :token, String, required: true

    field :access_token, Types::Objects::AccessTokenType, null: true

    def resolve(client_id:, token:)
      user = RefreshToken.fetch(client_id: client_id, raw: token)&.user
      access_token = AccessToken.new(user: user)
      { access_token: { token: access_token.issue } }
    end
  end
end
