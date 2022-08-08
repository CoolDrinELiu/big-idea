class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def create
    @post = Post.find(permitted_params[:post_id])
    @comments = @post.comments.includes([:user]).created_at_desc
    @group = @post.group
    authenticate_user_from_group!

    @post.comments.create(permitted_params.merge(user_id: current_user.id, group_id: @group.id))

    @pagy, @comments = pagy(@comments)
  end

  private
  def permitted_params
    params.require(:comment).permit(:content, :post_id, :reply_id)
  end
end
