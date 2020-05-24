# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if ENV.fetch('RAILS_ENV') == 'production'
      origins(/^#{ENV.fetch('HACKARU_WEB_URL')}$/)
    else
      origins '*'
    end

    resource '/graphql',
             headers: :any,
             methods: %i[post]

    resource '/v1/auth/*',
             headers: :any,
             methods: %i[get post put patch options delete],
             expose: %w[X-Client-Id X-Refresh-Token X-Access-Token]

    resource '/v1/oauth/authorize',
             headers: :any,
             methods: %i[get post put patch options delete]
  end

  allow do
    origins '*'

    resource '/v1/oauth/*',
             headers: :any,
             methods: %i[get post put patch options delete]

    resource '/v1/*',
             headers: :any,
             methods: %i[get post put patch options delete]

    resource '/api-docs/*',
             headers: :any,
             methods: %i[get post put patch options delete]
  end
end
