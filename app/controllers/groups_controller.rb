class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :join, :quit]
  def index
    get_list_records
  end

  def create
    record = current_user.owned_groups.new(permitted_group_params)
    @message_type, @message =
      if record.save
        [:valid, "Group ##{record.name} saved successfully"]
      else
        [:invalid, record.errors&.full_messages&.join("<br>")]
      end
    respond_to do |format|
      format.turbo_stream do
        get_list_records
      end
    end
  end

  def edit
    @group = current_user.owned_groups.find_by(id: params[:id])
  end

  def update
    record = current_user.owned_groups.find_by(id: params[:id])
    if record.update(permitted_group_params)
      flash[:notice] = "Group ##{record.name} updated successfully"
    else
      flash[:error] = "Something went wrong happened"
    end
    redirect_to root_path
  end

  def quit
    group = current_user.member_groups.find_by(id: params[:id])
    group.quit! current_user if group
    respond_to do |format|
      format.html { redirect_to root_path, status: 303 }
    end
  end

  def join
    # Public scope, for only public groups
    group = Group.in_public.find_by(id: params[:id])
    group.join! current_user if group
    respond_to do |format|
      format.html { redirect_to root_path, status: 303 }
    end
  end

  private
  def permitted_group_params
    params.require(:group).permit(*%w{name access_control})
  end

  def get_list_records
    @pagy, @groups =
      if user_signed_in?
        case params[:tab]
        when 'owned'
          pagy(current_user.owned_groups)
        when 'member'
          pagy(current_user.member_groups)
        else
          pagy(Group.all)
        end
      else
        pagy(Group.all)
      end
  end
end
