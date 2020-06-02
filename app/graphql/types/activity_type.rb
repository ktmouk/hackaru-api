# frozen_string_literal: true

module Types
  class ActivityType < Types::BaseObject
    field :id, Int, null: false
    field :description, String, null: false
    field :duration, Int, null: false
    field :started_at, GraphQL::Types::ISO8601DateTime, null: false
    field :stopped_at, GraphQL::Types::ISO8601DateTime, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :project, Types::ProjectType, null: true
  end
end
