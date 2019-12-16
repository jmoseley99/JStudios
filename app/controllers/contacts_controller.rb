class ContactsController < ApplicationController
  # Anybody can create an email to the company so there is no need for user authentication
  # or admin checks, for example, a user may have forgotten their password and may need a reset from the owner,
  # this would not be possible if they had to be signed in to form an email.
  def contact
    @contact = Contact.new(params[:contact])
  end

  # This method is used whenever a new contact email is created.
  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    respond_to do |format|
      if @contact.deliver
        @contact = Contact.new
        format.html { render 'contact'}
        flash.now[:error]
      else
        format.html { render 'contact' }
      end
    end
  end


end
