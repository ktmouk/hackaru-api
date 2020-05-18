# frozen_string_literal: true

class HackaruApiSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  use GraphQL::Execution::Errors

  rescue_from(ActiveRecord::RecordInvalid) do |error|
    ExecutionErrorBuilder.from_record_invalid(error).build
  end

  rescue_from(StandardError) do |error|
    builder = ExecutionErrorBuilder.from_exception(error)
    raise error unless builder
    builder.build
  end

   def self.unauthorized_object(error)
    raise ExecutionErrorBuilder.from_i18n(:permisson_denied).build
  end
end
