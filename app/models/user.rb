class User < ApplicationRecord
	include RatingAverage

	has_secure_password

	validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
	validates :password, presence: true, format: { with: /(?=.*[A-Z])(?=.*\d).{4,}/, message: "Make sure the password is at least four characters long and it contains at least one capital letter and one figure" }
	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings

	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, through: :memberships

	def favorite_beer
		return nil if ratings.empty?

		ratings.order(score: :desc).limit(1).first.beer
	end

	def favorite_style
		return nil if ratings.empty?

		ratings.order(score: :desc).limit(1).first.beer.style
	end

	def favorite_brewery
		return nil if ratings.empty?

		ratings.order(score: :desc).limit(1).first.beer.brewery.name
	end
end
