class CommentsController < ActiveUsersController
  before_action :set_chapter, only: [:list, :add]
  before_action :set_comments, only: [:list]

  def list
    render json: @comments
  end

  def add
    @comment = @chapter.comments.build
    @comment.user = active_user
    @comment.content = params[:content]

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end

  end

  def remove
    @comment = active_user.comments.find(params[:comment_id])
    head :no_content
  end

  def flag
  end

  private

  def set_chapter
    @chapter = Chapter.find(params[:chapter_id])
  end

  def set_comments
    @comments = @chapter.comments
  end

end
