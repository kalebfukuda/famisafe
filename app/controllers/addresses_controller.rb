class AddressesController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def index
    @addresses = current_user.addresses.distinct
    @address = Address.new
  end

  def show
  end

  def create
    @address = Address.new(params_address)
    if @address.save
      list_address = ListAddress.new
      list_address.contact = current_user.contact
      list_address.address = @address
      list_address.save
      @addresses = current_user.addresses.distinct
      redirect_to addresses_path
    else
      @addresses = current_user.addresses.distinct
      render :index, status: :unprocessable_content
    end
  end

  def reverse_geocode
    lat = params[:lat]
    lng = params[:lng]

    if lat.blank? || lng.blank?
      render json: { error: 'Latitude and longitude are required' }, status: :bad_request
      return
    end

    url = URI("https://nominatim.openstreetmap.org/reverse?lat=#{lat}&lon=#{lng}&format=json")
    req = Net::HTTP::Get.new(url)
    req['User-Agent'] = 'MyAppName/1.0 (kaleb@gmail.com)'

    res = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
      http.request(req)
    end

    if res.is_a?(Net::HTTPSuccess)
      data = JSON.parse(res.body)
      render json: {
        display_name: data['display_name'],
        address: data['address']
      }
    else
      render json: { error: 'Failed to fetch address' }, status: :bad_gateway
    end
      rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def params_address
    params.require(:address).permit(:description, :postal_code, :prefecture, :city, :block, :building_name, :latitude, :longitude, :type_place_id)
  end
end
