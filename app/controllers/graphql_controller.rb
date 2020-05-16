class GraphqlController < ApplicationController
  def execute
    render json: HackaruApiSchema.execute(
      params[:query],
      variables: ensure_hash(params[:variables]),
      context: { current_user: authenticate_user },
      operation_name: params[:operationName]
    )
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  # TMP
  def authenticate_user
    current_user = AccessToken.verify(request.headers['X-Access-Token'])
    Raven.user_context(id: current_user&.id)
    current_user
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
