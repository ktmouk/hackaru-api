# frozen_string_literal: true

class ExecutionErrorBuilder
  def initialize(message, code)
    @message = message
    @code = code.to_s.underscore.upcase
  end

  def build
    GraphQL::ExecutionError.new(
      @message,
      extensions: {
        code: @code
      }
    )
  end

  def self.from_i18n(code)
    translated = I18n.t(code, scope: :execution_error_builder, default: '')
    new(translated[:message], code) if translated.present?
  end

  def self.from_exception(exception)
    from_i18n(to_code(exception))
  end

  def self.from_record_invalid(exception)
    message = exception.record.errors.full_messages.first
    new(message, to_code(exception))
  end

  private

  def self.to_code(exception)
    "exception.#{exception.class.name.gsub(/::/, '.').underscore}"
  end
end
