class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :join, :quit, :show, :remove_member, :invite]

  def index
    get_list_records
    @pending_requests = current_user&.group_requests&.pending
  end

  def show
    @group = Group.find(params[:id])

    authenticate_user_from_group!

    @is_admin = @group.owned_by?(current_user)

    @pending_requests = @group.group_requests.pending.active if @is_admin

    @pagy, @posts =
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

  def remove_member
    @group = current_user.owned_groups.find(params[:id])
    @group.kick_out_member! params[:user_id_to_kick]
    @is_admin = @group.owned_by?(current_user)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def join
    group = Group.find(params[:id])
    if group.in_public?
      group.join! current_user
    elsif group.in_private?
      group.request_join! current_user
    end
    respond_to do |format|
      format.html { redirect_to root_path, status: 303 }
    end
  end

  def invite
    @group = Group.find(params[:id])

    authenticate_user_from_group!

    user_to_invite = User.find_by(email: params[:email])
    @invite_stauts =
      if user_to_invite
        @group.request_join! user_to_invite, "passive", current_user.id
        :done
      else
        :failed
      end
    respond_to do |format|
      format.turbo_stream
    end
  end

  def reject
    request = current_user.group_requests.find(params[:request_id])
    request.rejected!
    respond_to do |format|
      format.html { redirect_to root_path, status: 303 }
    end
  end

  def accept
    request = current_user.group_requests.find(params[:request_id])
    request.accept_the_invitation!
    respond_to do |format|
      format.html { redirect_to root_path, status: 303 }
    end
  end

  def approve_member
    @req = GroupRequest.find(params[:id])
    @req.add_member!
    group = current_user.owned_groups.find(@req.group_id)
    @is_admin = group.owned_by?(current_user)
    @pending_requests = group.group_requests.pending
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

  def authenticate_user_from_group!
    unless @group.can_access_by? current_user
      flash[:error] = "You are not allowed to visit this group yet."
      redirect_to root_path
    end
  end
end
