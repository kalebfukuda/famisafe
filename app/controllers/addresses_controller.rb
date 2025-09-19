class AddressesController < ApplicationController
  def index
    @addresses = current_user.addresses.distinct
  end

  def show
  end

  def new

  end

  def create

  end
end
