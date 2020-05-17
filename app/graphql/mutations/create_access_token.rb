# frozen_string_literal: true

module Mutations
  class CreateAccessToken < BaseMutation
    argument :client_id, String, required: true
    argument :token, String, required: true

    field :access_token, Types::AccessTokenType, null: true

    def resolve(client_id:, token:)
      {
        access_token: {
          token: issue_access_token(client_id, token)
        }
      }
    end

    private

    def issue_access_token(client_id, token)
      user = RefreshToken.fetch(client_id: client_id, raw: token)&.user
      AccessToken.new(user: user).issue
    end
  end
end
