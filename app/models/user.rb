# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email,
            presence: true,
            uniqueness: true,
            length: { maximum: 100 },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { in: 6..50 }, allow_nil: true

  with_options dependent: :delete do
    has_one :password_reset_token
    has_one :activity_calendar
  end

  with_options dependent: :delete_all do
    has_many :projects
    has_many :activities
    has_many :refresh_tokens
    has_many :webhooks
  end

  def reset_password(token:, password:, password_confirmation:)
    return false if password_reset_token&.expired?
    return false if password_reset_token != token

    update!(
      password: password,
      password_confirmation: password_confirmation
    )
    password_reset_token.destroy!
    true
  end

  def add_sample_projects
    names = I18n.t('sample_projects')
    projects << [
      Project.new(color: '#4ab8b8', name: names[0]),
      Project.new(color: '#a1c45a', name: names[1]),
      Project.new(color: '#f95959', name: names[2])
    ]
  end
end
