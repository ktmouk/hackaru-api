# frozen_string_literal: true

module Mutations
  class DeleteActivity < BaseMutation
    include Mutations::Concerns::Authorizable

    argument :id, ID, required: true

    field :activity, Types::ActivityType, null: true

    def resolve(**args)
      { activity: destroy_activity(context[:current_user].id, args) }
    end

    private

    def destroy_activity(user_id, args)
      id = args.delete(:id)
      activity = Activity.find_by!(id: id, user_id: user_id)
      activity.destroy!
      activity
    end
  end
end
