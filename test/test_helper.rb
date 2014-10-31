ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def admin_login
    logged_admin = manage_admins(:admin_one)
    session[:admin_user_id]=logged_admin.id
    session[:admin_user_uid]=logged_admin.uid
  end

  def admin_logout
    session[:admin_user_id]=nil
    session[:admin_user_uid]=nil
  end
end
