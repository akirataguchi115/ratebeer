class MembershipsController < ApplicationController
	before_action :set_membership, only: %i[show edit update destroy]

	# GET /memberships or /memberships.json
	def index
		@memberships = Membership.all
	end

	# GET /memberships/new
	def new
		@membership = Membership.new
		@beer_clubs = BeerClub.all
	end

	# POST /memberships or /memberships.json
	def create
		@membership = Membership.create params.require(:membership).permit(:beer_club_id)
		@membership.user_id = current_user.id

		if @membership.save
			redirect_to user_path current_user
		else
			@memberships = Membership.all
			render :new, status: :unprocessable_entity
		end
	end

	# DELETE /memberships/1 or /memberships/1.json
	def destroy
		@membership.destroy

		respond_to do |format|
			format.html { redirect_to memberships_url, notice: "Membership was successfully destroyed." }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_membership
			@membership = Membership.find(params[:id])
		end

		# Only allow a list of trusted parameters through.
		def membership_params
			params.require(:membership).permit(:beer_club_id, :user_id)
		end
end
