module GroupHelper
  def active_tab_class tab
    active_class = 'border-l border-t border-r'
    return active_class if params[:tab].blank? && tab == "all"
    params[:tab] == tab ? 'border-l border-t border-r' : ""
  end
end
