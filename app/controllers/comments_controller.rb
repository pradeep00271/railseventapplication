class CommentsController < ApplicationController




  def create
    @event = Event.find(params[:event_id])
    @comment = @event.comments.create(comment_params)

    if @comment.save
      UserMailer.signup_email(@event.id).deliver_later
      redirect_to @event
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @comment = Comment.find(params[:id])




  end

  def update
    @event = Event.find(params[:event_id])
    @comment = Comment.find(params[:id])

      if @comment.update(comment_params)
        flash[:notice] = "Comment was successfully edited"
        redirect_to @event
      else
        render 'edit'

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
