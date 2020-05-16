module Types
  class UserInput < BaseInputObject
    argument :email, String, required: true
    argument :password, String, required: true
    argument :time_zone, String, required: true
    argument :locale, String, required: true
  end
end
