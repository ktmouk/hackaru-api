# frozen_string_literal: true

module Types
  class RefreshTokenType < Types::BaseObject
    field :client_id, String, null: false
    field :token, String, null: false
  end
end
