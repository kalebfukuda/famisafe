class HazardsController < ApplicationController
  def saveHazard
    hazard = Hazards.new(params_hazards)
  end

  private

  def params_hazards
    params.require(:hazards).permit(:code, :occurrence, :type, :latitude, :longitude, :magnitude)
  end
end
