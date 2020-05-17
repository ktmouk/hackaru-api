# frozen_string_literal: true

module ExecutionError
  class Localizer
    def initialize(code, scope = :execution_error_builder)
      @code = code
      @scope = scope
    end

    def build
      ExecutionError::Builder.new(
        @code,
        translated[:message]
      ).build
    end

    def exists?
      translated.present?
    end

    private

    def translated
      I18n.t(@code, scope: @scope, default: '')
    end
  end
end
