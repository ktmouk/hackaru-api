# frozen_string_literal: true

module Queries
  module ViewerQuery
    extend ActiveSupport::Concern

    included do
      field :viewer, Types::UserType, null: false
    end

    def viewer
      return context[:current_user] if context[:current_user]
      raise ExecutionErrorBuilder.from_i18n(:access_token_invalid).build
    end
  end
end
