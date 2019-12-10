class ContactTest < ActiveSupport::TestCase
  setup do
    @name = "Foo Bar"
    @email_name = "foo@bar.com"
    @message = "Help me with testing!"
  end

  #This test ensures that a valid contact email can be created
  test "create valid contact email" do
    msg = Contact.new(name: @name, email: @email_name, message: @message)
    assert msg.save
  end

  #This test ensures that a contact email cannot be created without a name given
  test "create invalid email with no name" do
    msg = Contact.new(name: '', email: @email_name, message: @message)
    assert_not msg.save
  end

  #This test ensures that a contact email cannot be created without an email given
  test "create invalid email with no email" do
    msg = Contact.new(name: @name, email: '', message: @message)
    assert_not msg.save
  end

  #This test ensures that a contact email cannot be created without a message given
  test "create invalid email with no message" do
    msg = Contact.new(name: @name, email: @email_name, message: '')
    assert_not msg.save
  end
end
