require 'rails_helper'

include Helpers

describe "Beers page" do

	before :each do
		sign_in(username: "Pekka", password: "Foobar1")
		@breweries = ["Koff", "Karjala", "Schlenkerla"]
		year = 1896
		@breweries.each do |brewery_name|
			FactoryBot.create(:brewery, name: brewery_name, year: year += 1)
		end
	end

	it "allows user to add a beer" do
		visit new_beer_path
		fill_in('beer_name', with: 'Kalja')
		select('Lager', from: 'beer[style]')
		select('Koff', from: 'beer[brewery_id]')
	
		expect{
			click_button('Create Beer')
		}.to change{Beer.count}.by(1)
	end

	it "does not allow user to add a beer without a name" do
		visit new_beer_path
		select('Lager', from: 'beer[style]')
		select('Koff', from: 'beer[brewery_id]')

		click_button('Create Beer')
		expect(Beer.count).to eq(0)
		expect(current_path + "/new").to eq(new_beer_path)
		expect(page).to have_content 'Name can\'t be blank'
	end
end