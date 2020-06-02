# frozen_string_literal: true

class ApplicationController < ActionController::API
  include HttpAcceptLanguage::AutoLocale
  include JWTSessions::RailsAuthorization
  include Authenticatable
  include ErrorRenderable
  include RavenExtraContext
end
