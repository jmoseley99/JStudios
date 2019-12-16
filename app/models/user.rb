class User < ApplicationRecord
  include Clearance::User
  has_many :bookings

  # Clearance takes care of the validation for new users
end
