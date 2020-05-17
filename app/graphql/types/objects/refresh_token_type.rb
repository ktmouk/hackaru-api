# frozen_string_literal: true

module Types
  module Objects
    class RefreshTokenType < Types::Objects::BaseObject
      field :client_id, String, null: false
      field :token, String, null: false
    end
  end
end
