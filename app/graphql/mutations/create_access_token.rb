module Mutations
  class CreateAccessToken < BaseMutation
    argument :client_id, String, required: true
    argument :token, String, required: true

    field :access_token, Types::AccessTokenType, null: true

    def resolve(client_id:, token:)
      user = RefreshToken.fetch(client_id: client_id, raw: token)&.user
      token = AccessToken.new(user: user).issue
      { access_token: { token: token } }
    end
  end
end
