# frozen_string_literal: true

module Types
  module Queries
    class QueryType < Types::Objects::BaseObject
      field :project, Types::Objects::ProjectType, null: false do
        argument :id, Int, required: true
      end
      def project(id:)
        Project.find(id)
      end

      field :project, [Types::Objects::ProjectType], null: false
      def projects
        Project.all
      end
    end
  end
end
