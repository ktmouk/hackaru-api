# frozen_string_literal: true

module Types
  class ProjectType < Types::BaseObject
    field :id, Int, null: false
    field :name, String, null: false
    field :color, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end