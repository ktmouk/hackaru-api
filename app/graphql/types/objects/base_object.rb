# frozen_string_literal: true

module Types
  module Objects
    class BaseObject < GraphQL::Schema::Object
      field_class Types::Fields::BaseField
    end
  end
end
