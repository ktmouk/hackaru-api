# frozen_string_literal: true

module ExecutionError
  class Validation
    delegate :build, to: :@builder

    def initialize(validation_error)
      @builder = ExecutionError::Builder.new(
        validation_error.class.name.gsub(/::/, '.'),
        validation_error.record.errors.full_messages.first
      )
    end
  end
end
