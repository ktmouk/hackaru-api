# frozen_string_literal: true

module Mutations
  class CreateProject < BaseMutation
    argument :name, String, required: true
    argument :color, String, required: true

    field :project, Types::Objects::ProjectType, null: true

    def resolve(name:, color:)
      {
        project: Project.create!(
          user: context[:current_user],
          name: name,
          color: color
        )
      }
    end
  end
end
