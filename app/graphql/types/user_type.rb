# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, Int, null: false
    field :email, String, null: false
    field :time_zone, String, null: false
    field :locale, String, null: false
    field :receive_week_report, Boolean, null: false
    field :receive_month_report, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :projects, [Types::ProjectType], null: false
  end
end
