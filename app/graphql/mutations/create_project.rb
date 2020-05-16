module Mutations
  class CreateProject < Mutations::BaseMutation
    argument :user_id, Int, required: true
    argument :name, String, required: true
    argument :color, String, required: true

    field :project, Types::ProjectType, null: true
    field :errors, [String], null: false

    def resolve(user_id:, name:, color:)
      project = Project.new(user_id: user_id, name: name, color: color)

      if project.save
        {
          project: project,
          errors: []
        }
      else
        {
          project: nil,
          errors: project.errors.full_messages
        }
      end
    end
  end
end
