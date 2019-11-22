class ContactsController < ApplicationController
  def contact
    @contact = Contact.new(params[:contact])
  end

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
        #format.js   { flash.now[:error] = @message = "Message did not send." }
      end
    end
  end
end