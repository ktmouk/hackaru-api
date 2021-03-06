# frozen_string_literal: true

module XhrValidatable
  private

  def validate_xhr!
    valid = request.xhr? && valid_origin?
    render_api_error_of :authenticate_failed unless valid
  end

  def valid_origin?
    request.origin.nil? || request.origin == ENV.fetch('HACKARU_WEB_URL')
  end
end
