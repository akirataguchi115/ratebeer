require 'rails_helper'

include Helpers

describe "User" do
	let!(:user) { FactoryBot.create :user }
	let!(:user2) { FactoryBot.create :user, username: "Teppo" }

	describe "who has signed up" do
		it "can signin with right credentials" do
			sign_in(username: "Pekka", password: "Foobar1")

			expect(page).to have_content 'Welcome back!'
			expect(page).to have_content 'Pekka'
		end
		
		it "is redirected back to signin form if wrong credentials given" do
			sign_in(username: "Pekka", password: "wrong")

			expect(current_path).to eq(signin_path)
			expect(page).to have_content 'Username and/or password mismatch'
		end

		it "when signed up with good credentials, is added to the system" do
			visit signup_path
			fill_in('user_username', with: 'Brian')
			fill_in('user_password', with: 'Secret55')
			fill_in('user_password_confirmation', with: 'Secret55')
		
			expect{
				click_button('Create User')
			}.to change{User.count}.by(1)
		end

		it "can see their ratings when signed in" do
			sign_in(username: "Pekka", password: "Foobar1")
			FactoryBot.create :rating, score: 5, user: user
			FactoryBot.create :rating, score: 6, user: user
			FactoryBot.create :rating, score: 7, user: user
			FactoryBot.create :rating, score: 8, user: user
			FactoryBot.create :rating, score: 9, user: user2
			visit user_path(user)
			expect(page).to have_content '7'
			expect(page).to have_no_content '9'
		end
	end
end