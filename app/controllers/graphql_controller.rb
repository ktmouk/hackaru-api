# frozen_string_literal: true

class GraphqlController < ApplicationController
  def execute
    render json: HackaruApiSchema.execute(
      params[:query],
      variables: ensure_hash(params[:variables]),
      context: { current_user: current_user },
      operation_name: params[:operationName]
    )
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  def current_user
    authorize_by_access_cookie!
    user = User.find(claimless_payload['user_id'])
    Raven.user_context(id: user&.id)
    user
  rescue JWTSessions::Errors::Unauthorized
    nil
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      ambiguous_param.present? ? ensure_hash(JSON.parse(ambiguous_param)) : {}
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(exception)
    logger.error exception.message
    logger.error exception.backtrace.join("\n")

    errors = { message: exception.message, backtrace: exception.backtrace }
    render json: { errors: [errors], data: {} }, status: 500
  end
end