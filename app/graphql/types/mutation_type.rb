# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_project, mutation: Mutations::CreateProject
    field :create_activity, mutation: Mutations::CreateActivity
    field :update_activity, mutation: Mutations::UpdateActivity
    field :create_user, mutation: Mutations::CreateUser
    field :create_refresh_token, mutation: Mutations::CreateRefreshToken
    field :create_access_token, mutation: Mutations::CreateAccessToken
  end
end
