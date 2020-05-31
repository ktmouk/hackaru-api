# frozen_string_literal: true

module Mutations
  module Concerns
    module Authorizable
      def ready?(**_args)
        return true if context[:current_user]

        raise_error :access_token_invalid
      end
    end
  end
end
