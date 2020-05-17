# frozen_string_literal: true

module ExecutionError
  class Exception
    delegate :build, :exists?, to: :@builder

    def initialize(exception)
      @builder = ExecutionError::Localizer.new(
        exception.class.name.gsub(/::/, '.').underscore,
        :exception_error_builder
      )
    end
  end
end
