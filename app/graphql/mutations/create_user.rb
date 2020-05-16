module Mutations
  class CreateUser < BaseMutation
    argument :user, Types::UserInput, required: false

    field :user, Types::UserType, null: false

    def resolve(user:)
      { user: UserInitializer.new(user.to_h).create! }
    end
  end
end
