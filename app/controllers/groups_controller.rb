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

    @pending_requests = @group.group_requests.pending.active.includes([:user]) if @is_admin

    @pagy, @posts = pagy(@group.posts.created_at_desc)
  end

  def create
    record = current_user.owned_groups.new(permitted_group_params)
    @message_type, @message =
      if record.save
        [:valid, "##{record.name} created successfully. Do you want to create a new one again?"]
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

  # To join a group
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

  # To invite people
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

  # For invitation
  def reject
    request = current_user.group_requests.find(params[:request_id])
    request.rejected!
    respond_to do |format|
      format.html { redirect_to root_path, status: 303 }
    end
  end

  # For invitation
  def accept
    request = current_user.group_requests.find(params[:request_id])
    request.accept_the_invitation!
    respond_to do |format|
      format.html { redirect_to root_path, status: 303 }
    end
  end

  # Approve or reject a group request
  def process_group_request
    @req = GroupRequest.find(params[:id])
    @group = Group.find @req.group_id
    @is_admin = @group.owned_by?(current_user)

    unless @is_admin
      flash[:error] = "You are not allowed to do this."
      redirect_to root_path, status: 303
    end

    if params[:decision] == "approve"
      @req.add_member!
    else
      @req.rejected!
    end
    group = current_user.owned_groups.find(@req.group_id)
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
          pagy(current_user.owned_groups.created_at_desc)
        when 'member'
          pagy(current_user.member_groups.created_at_desc)
        else
          pagy(Group.all.created_at_desc)
        end
      else
        pagy(Group.all.created_at_desc)
      end
  end

end
