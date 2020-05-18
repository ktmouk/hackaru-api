# frozen_string_literal: true

module Mutations
  class CreateAccessToken < BaseMutation
    argument :client_id, String, required: true
    argument :token, String, required: true

    field :access_token, Types::AccessTokenType, null: true

    def resolve(client_id:, token:)
      access_token = issue_access_token!(client_id, token)
      { access_token: { token: access_token.issue } }
    end

    private

    def issue_access_token!(client_id, token)
      user = RefreshToken.fetch(client_id: client_id, raw: token)&.user
      raise_error :refresh_token_invalid unless user
      AccessToken.new(user: user)
    end
  end
end
