class Beer < ApplicationRecord
	belongs_to :brewery
end

class Brewery < ApplicationRecord
	has_many :beers
end