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
    ExecutionError::Validation.new(error).build
  end

  rescue_from(StandardError) do |error|
    builder = ExecutionError::Exception.new(error)
    raise error unless builder.exists?
    builder.build
  end
end
