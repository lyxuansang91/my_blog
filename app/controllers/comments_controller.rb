class CommentsController < ApplicationController

  before_action :signed_in_user, only: [:create]

  def show
  end

  def create
    @entry = Entry.find(params[:entry_id])
    @user = @entry.user unless @entry.nil?
    #byebug
    @comment = @entry.comments.build(params.require(:comment).permit!)
    if current_user?(@user) || current_user.followed_users.include?(@user)
      flash[:success] = "Comment is posted successfully"
      @comment.save

    else
      flash[:danger] = "No permission to post a comment"
    end
    redirect_to entry_path(@entry)
  end
end
