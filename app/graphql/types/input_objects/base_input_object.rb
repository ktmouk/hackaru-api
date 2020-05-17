# frozen_string_literal: true

module Types
  module InputObjects
    class BaseInputObject < GraphQL::Schema::InputObject
      argument_class Types::Arguments::BaseArgument
    end
  end
end
