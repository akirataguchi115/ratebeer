require 'rails_helper'

RSpec.describe Beer, type: :model do
	it 'has the name, brewery and style set correctly' do
		brewery = Brewery.create name: "Sinebrychoff", year: 1918
		beer = Beer.create name: "Karhu 4,6", brewery: brewery, style: "Lager"

		expect(Beer.count).to eq(1)
	end

	it 'is not saved without a name' do
		brewery = Brewery.create name: "Sinebrychoff", year: 1918
		beer = Beer.create brewery: brewery, style: "Lager"

		expect(Beer.count).to eq(0)
	end

	it 'is not saved without a style' do
		brewery = Brewery.create name: "Sinebrychoff", year: 1918
		beer = Beer.create name: "Karhu 4,6", brewery: brewery

		expect(Beer.count).to eq(0)
	end
end