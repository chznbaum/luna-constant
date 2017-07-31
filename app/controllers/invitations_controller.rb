class InvitationsController < Devise::InvitationsController
  before_action :check_invite_privileges, only: [:new]

  def check_invite_privileges
    forbidden! unless logged_in?(:site_admin, :helper)
  end
end