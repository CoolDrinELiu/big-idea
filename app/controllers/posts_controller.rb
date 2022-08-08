class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def show
  end

  def create
    @group = Group.find(permitted_params[:group_id])
    @group.posts.create(permitted_params.merge(user_id: current_user.id))
  end

  def edit
  end

  def update
  end

  def destroy

  end

  private
  def permitted_params
    params.require(:post).permit(:title, :content, :group_id)
  end
end
