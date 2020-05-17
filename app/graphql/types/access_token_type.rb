# frozen_string_literal: true

module Types
  class AccessTokenType < Types::BaseObject
    field :token, String, null: false
  end
end
