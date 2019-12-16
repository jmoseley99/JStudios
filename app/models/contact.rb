class Contact < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,    :validate => true
  attribute :nickname,  :captcha  => true
  validate :inputs_exist
  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        :subject => "Contact Form Inquiry",
        :to => "jacob.moseley12345@gmail.com",
        :from => %("#{name}" <#{email}>)
    }
  end

  # This validation method ensures that the name, email and message are all filled in in order to be
  # able to send a contact email
  def inputs_exist
    if name.nil?
      errors.add(:name, "must exist")
    end
    if email.nil?
      errors.add(:email, "must exist")
    end
    if message.nil?
      errors.add(:message, "must have a body")
    end
  end

end
