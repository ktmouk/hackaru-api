module Types
  class QueryType < Types::BaseObject
    field :project, Types::ProjectType, null: false do
      argument :id, Int, required: true
    end
    def project(id:)
      Project.find(id)
    end

    field :project, [Types::ProjectType], null: false
    def project
      Project.all
    end
  end
end
