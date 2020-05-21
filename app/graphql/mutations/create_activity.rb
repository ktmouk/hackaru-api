# frozen_string_literal: true

module Mutations
  class CreateActivity < BaseMutation
    include Mutations::Concerns::Authorizable

    argument :description, String, required: false
    argument :project_id, Int, required: false
    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :stopped_at, GraphQL::Types::ISO8601DateTime, required: false

    field :activity, Types::ActivityType, null: true

    def resolve(**args)
      {
        activity: Activity.create!(
          args.merge(user_id: context[:current_user].id)
        )
      }
    end
  end
end
