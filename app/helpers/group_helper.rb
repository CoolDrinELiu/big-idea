module GroupHelper
  def active_tab_class tab
    active_class = 'border-l border-t border-r'
    return active_class if params[:tab].blank? && tab == "all"
    params[:tab] == tab ? 'border-l border-t border-r' : ""
  end

  def has_been_invited_by? group
    inviting_request_of(group).present?
  end

  def inviting_request_of group
    @pending_requests.passive.find_by(group_id: group.id)
  end
end
