module Mutations
  module Concerns
    module Authorizable
      def ready?(**args)
        return true if context[:current_user]
        raise_error :access_token_invalid
      end
    end
  end
end
