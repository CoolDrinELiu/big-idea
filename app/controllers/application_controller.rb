class ApplicationController < ActionController::Base
  include Pagy::Backend

  public
  def authenticate_user_from_group!
    return true if current_user.admin?
    unless @group.can_access_by? current_user
      flash[:error] = "You are not allowed to visit this group yet."
      redirect_to root_path, status: 303
    end
  end
end
