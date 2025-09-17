class FamiliesController < ApplicationController
  def create
    @family = Family.new(params_family)
    if @family.save
      current_user.family = @family
      current_user.save
      redirect_to new_contact_path
    else
      render :new, unprocessable_content
    end
  end

  def new
    @family = Family.new
  end

  private

  def params_family
    params.require(:family).permit(:name)
  end
end
