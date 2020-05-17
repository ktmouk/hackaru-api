# frozen_string_literal: true

module Queries
  module ProjectsQuery
    extend ActiveSupport::Concern

    included do
      field :projects, [Types::ProjectType], null: false

      field :project, Types::ProjectType, null: false do
        argument :id, GraphQL::Types::Int, required: true
      end
    end

    def projects
      context[:current_user].projects
    end

    def project(id:)
      context[:current_user].projects.find(id)
    end
  end
end
