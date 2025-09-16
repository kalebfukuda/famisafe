class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params_contact)
  end

  private

  def params_contact
    params.require(:contact).permit(:name, :telephone, :email, :relationship)
  end
end
