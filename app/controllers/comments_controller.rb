class CommentsController < ApplicationController
  before_action :logged_in_user , only: [:create]
  before_action :find_micropost

  #def new
  #  @micropost = micropost.find params[:micropost_id]
  #  @comment = @micropost.comments.new(comment_attributes)
  #end

  def create
      @micropost = Micropost.find params[:micropost_id]
      @comment = @micropost.comments.new(comment_attributes)

      if logged_in? && @comment.save
        flash[:success] = "comment created successfully."
        redirect_to @micropost 
      else
        render "/microposts/show"
      end
  end
  #def create
  #  @micropost = Micropost.find(params[:micropost_id])
  #  @comment = @micropost.comments.create(params[:comment])
  #  redirect_to micropost_path(@micropost)
  #end

  private
  def find_micropost
    @micropost = Micropost.find(params[:micropost_id] || params[:id])
    redirect_to root_path, flash[:warning] = "Access denied" unless @micropost
  end

  def comment_attributes
    params.require(:comment).permit([:body, :user_id, :micropost_id])
  end
end
