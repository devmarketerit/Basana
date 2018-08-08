class Api::CommentsController < ApplicationController

  before_action :require_login

  def index
    @comments = Task.find(comment_params[:task_id]).comments.includes(:author)
    render 'api/comments/index'
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render 'api/comments/show'
    else
      render json: @comment.errors.full_messages, status: 422
    end
  end

  def show
    @comment = Comment.find(params[:id])
    render 'api/comments/show'
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      render 'api/comments/show'
    else
      render json: @comment.errors.full_messages, status: 422
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy!
    render json: {}
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :task_id, :content)
  end
end
