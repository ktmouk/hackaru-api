module Mutations
  class CreateUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :time_zone, String, required: true
    argument :locale, String, required: true

    field :user, Types::UserType, null: false

    def resolve(**user)
      { user: UserInitializer.new(user).create! }
    end
  end
end
