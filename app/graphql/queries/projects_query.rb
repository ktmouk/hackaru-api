# frozen_string_literal: true

module Queries
  module ProjectsQuery
    extend ActiveSupport::Concern

    included do
      field :projects, [Types::ProjectType], null: false do
        argument :user_id, GraphQL::Types::Int, required: true
      end

      field :project, Types::ProjectType, null: false do
        argument :id, GraphQL::Types::Int, required: true
      end
    end

    def projects(user_id:)
      User.find(user_id).projects
    end

    def project(id:)
      Project.find(id)
    end
  end
end
