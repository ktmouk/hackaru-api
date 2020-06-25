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
    field :working_activity, Types::ActivityType, null: true

    field :stopped_activities, [Types::ActivityType], null: false do
      argument :from, GraphQL::Types::ISO8601DateTime, required: false
      argument :to, GraphQL::Types::ISO8601DateTime, required: false
    end

    def working_activity
      object.activities.find_by(stopped_at: nil)
    end

    def stopped_activities(args)
      object.activities
        .where(started_at: args[:from]..args[:to])
        .where.not(stopped_at: nil)
        .order(started_at: :desc)
    end
  end
end
