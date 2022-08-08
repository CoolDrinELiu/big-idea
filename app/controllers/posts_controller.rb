class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @group = @post.group
    authenticate_user_from_group!

    comments = @post.comments.includes(:user, :reply).created_at_desc

    @pagy, @comments = pagy(comments)
  end

  def create
    @group = Group.find(permitted_params[:group_id])
    @group.posts.create(permitted_params.merge(user_id: current_user.id))
    @pagy, @posts = pagy(@group.posts.created_at_desc)
  end

  def edit
    #WIP
  end

  def update
    #WIP
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.able_to_remove_by? current_user
      @post.destroy
      flash[:notice] = "Post has been deleted"
      redirect_to root_path, status: 303
    end
  end

  private
  def permitted_params
    params.require(:post).permit(:title, :content, :group_id)
  end
end
