class Beer < ApplicationRecord
	belongs_to :brewery
	has_many :ratings

	def average_rating
		ratings.sum(&:score) / ratings.count.to_f
	end
end
