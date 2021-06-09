class CommentsController < ApplicationController

  before_action :authenticate_user!, except: [:index,:show]

  def create
    @event = Event.find(params[:event_id])
    @comment = @event.comments.create(comment_params)

    if @comment.save
      redirect_to @event
    end
  end


  def destroy
    @event = Event.find(params[:event_id])
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to @event
  end


  private
  def comment_params
    params.require(:comment).permit(:comment, :user_id)
  end
end
