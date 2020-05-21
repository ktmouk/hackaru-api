# frozen_string_literal: true

module Mutations
  class CreateUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :time_zone, String, required: true
    argument :locale, String, required: true

    field :user, Types::UserType, null: false
    field :refresh_token, Types::RefreshTokenType, null: false

    def resolve(**args)
      user = UserInitializer.new(args).create!
      refresh_token, raw = RefreshToken.issue(user)
      {
        user: user,
        refresh_token: {
          client_id: refresh_token.client_id,
          token: raw
        }
      }
    end
  end
end
