require 'rails_helper'

RSpec.describe User, type: :model do
	def create_beer_with_rating(object, score, style, brewery)
		beer = FactoryBot.create(:beer)
		if style != "" then
			beer.style = style
		end
		if brewery != "" then
			beer.brewery.name = brewery
		end

		FactoryBot.create(:rating, beer: beer, score: score, user: object[:user])
		beer
	end

	def create_beers_with_many_ratings(object, *scores)
		scores.each do |score|
			create_beer_with_rating(object, score, "", "")
		end
	end

	it "has the username set correctly" do
		user = User.new username: "Pekka"

		expect(user.username).to eq("Pekka")
	end

	it "is not saved without a password" do
		user = User.create username: "Pekka"

		expect(user).not_to be_valid
		expect(User.count).to eq(0)
	end

	it "is not saved with a too short password or a password made of letters only" do
		user = User.create username: "Pekka", password: "no"

		expect(user).not_to be_valid
		expect(User.count).to eq(0)
	end

	describe "with a proper password" do
		let(:user) { FactoryBot.create(:user) }
	
		it "is saved" do
			expect(user).to be_valid
			expect(User.count).to eq(1)
		end
	
		it "and with two ratings, has the correct average rating" do
			FactoryBot.create(:rating, score: 10, user: user)
			FactoryBot.create(:rating, score: 20, user: user)
	
			expect(user.ratings.count).to eq(2)
			expect(user.average_rating).to eq(15.0)
		end
	end

	describe "favorite beer" do
		let(:user){ FactoryBot.create(:user) }
	
		it "has method for determining one" do
			expect(user).to respond_to(:favorite_beer)
		end
	
		it "without ratings does not have one" do
			expect(user.favorite_beer).to eq(nil)
		end

		it "is the one with highest rating if several rated" do
			create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
			best = create_beer_with_rating({user: user}, 25, "", "")
			expect(user.favorite_beer).to eq(best)
		end
	end

	describe "favorite style" do
		let(:user){ FactoryBot.create(:user) }

		it "has method for determining one" do
			expect(user).to respond_to(:favorite_style)
		end

		it "without ratings does not have one" do
			expect(user.favorite_style).to eq(nil)
		end

		it "is the one with highest rating if several rated" do
			create_beers_with_many_ratings({user: user}, 10, 20, 15, 7,9)
			best = create_beer_with_rating({user: user}, 25, "IPA", "")
			expect(user.favorite_style == (best.style))
		end
	end

	describe "favorite brewery" do
		let(:user){ FactoryBot.create(:user) }

		it "has method for determining one" do
			expect(user).to respond_to(:favorite_brewery)
		end

		it "without ratings does not have one" do
			expect(user.favorite_brewery).to eq(nil)
		end

		it "is the one with highest rating if several rated" do
			create_beers_with_many_ratings({user: user}, 10, 20, 15, 7,9)
			best = create_beer_with_rating({user: user}, 25, "IPA", "Hartwall")
			expect(user.favorite_brewery == (best.brewery))
		end
	end
end