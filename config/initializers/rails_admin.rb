RailsAdmin.config do |config|
  config.main_app_name = ["JStudios"]
  config.parent_controller = "::ApplicationController"

  #Only allow an admin account to access the dashboard
  config.authorize_with do
    unless current_user.is_admin?
      redirect_to(
          "/index",
          alert: "You are not permitted to view this page"
      )
    end
  end

  #Configure so when an admin is creating a new user/admin from the dashboard, no errors occur due to a problem
  # with clearence and rails_admin
  config.model "User" do
    edit do
      field :is_admin
      field :email
      field :password
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

  end
end
