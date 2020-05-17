# frozen_string_literal: true

module ExecutionError
  class Builder
    def initialize(code, message)
      @code = code
      @message = message
    end

    def build
      GraphQL::ExecutionError.new(
        @message,
        extensions: {
          code: @code.to_s.underscore.upcase
        }
      )
    end
  end
end
