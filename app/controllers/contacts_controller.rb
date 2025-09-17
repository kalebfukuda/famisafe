class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
    @family = Family.new if current_user.family.nil?
  end

  def create
    @contact = Contact.new(params_contact)
    @contact.family = current_user.family
    if @contact.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def params_contact
    params.require(:contact).permit(:name, :telephone, :email, :relationship, :latitude, :longitude)
  end
end
