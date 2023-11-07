class User < ApplicationRecord
	include RatingAverage

	has_secure_password

	validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
	validates :password, presence: true, format: { with: /(?=.*[A-Z])(?=.*\d).{4,}/, message: "Make sure the password is at least four characters long and it contains at least one capital letter and one figure" }
	has_many :ratings
	has_many :beers, through: :ratings

	has_many :memberships
	has_many :beer_clubs, through: :memberships
end
