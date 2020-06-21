# frozen_string_literal: true

module Mutations
  class UpdateActivity < BaseMutation
    include Mutations::Concerns::Authorizable

    argument :id, ID, required: true
    argument :description, String, required: false
    argument :project_id, Int, required: false
    argument :started_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :stopped_at, GraphQL::Types::ISO8601DateTime, required: false

    field :activity, Types::ActivityType, null: true

    def resolve(**args)
      { activity: update_activity(context[:current_user].id, args) }
    end

    private

    def update_activity(user_id, args)
      id = args.delete(:id)
      activity = Activity.find_by!(id: id, user_id: user_id)
      activity.update(**args)
      activity
    end
  end
end
