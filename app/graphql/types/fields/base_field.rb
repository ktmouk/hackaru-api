# frozen_string_literal: true

module Types
  module Fields
    class BaseField < GraphQL::Schema::Field
      argument_class Types::Arguments::BaseArgument
    end
  end
end
