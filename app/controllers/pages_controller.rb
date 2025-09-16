class PagesController < ApplicationController
 before_action :authenticate_user!, only: [:home]

  def home
    @contacts = current_user.contacts
  end
end
