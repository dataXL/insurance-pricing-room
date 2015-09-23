class AccountController < ApplicationController

	def settings
    @user = User.find(1)
	end

	def billing
	end

	def notifications
	end

	def support
	end

end
