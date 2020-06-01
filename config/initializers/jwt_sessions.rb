# frozen_string_literal: true

JWTSessions.encryption_key = ENV.fetch(
  'JWT_SESSIONS_ENCRYPTION_KEY',
  Rails.application.secret_key_base
)

JWTSessions.access_exp_time = ENV.fetch(
  'JWT_SESSIONS_ACCESS_EXP_TIME',
  3600
)

JWTSessions.refresh_exp_time = ENV.fetch(
  'JWT_SESSIONS_REFRESH_EXP_TIME',
  31_536_000
)

JWTSessions.token_store = :redis, {
  redis_url: ENV.fetch('REDIS_URL', 'redis://redis:6379/0')
}
