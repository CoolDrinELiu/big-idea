module ApplicationHelper
  include Pagy::Frontend

  def able_to_remove? record
    is_the_owner = current_user && record.user&.id == current_user.id

    return true if current_user.admin?
    return true if is_the_owner
  end
end
