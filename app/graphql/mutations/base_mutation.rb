# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    def raise_error(code)
      raise ExecutionErrorBuilder.from_i18n(code).build
    end
  end
end
