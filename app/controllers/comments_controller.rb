class CommentsController < ActiveUsersController
  before_action :set_chapter, only: [:index, :add]
  before_action :set_comments, only: [:index  ]

  def index
    @user =active_user
    @story = @chapter.story

  end

  def add
    @comment = @chapter.comments.build
    @comment.user = active_user
    @comment.content = params[:content]

    if @comment.save
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end

  end

  def remove
    @comment = active_user.comments.find(params[:comment_id]).destroy
    head :no_content
  end

  def flag
  end

  private

  def set_chapter
    @chapter = Chapter.find(params[:chapter_id])
  end

  def set_comments
    @comments = @chapter.comments.older
  end

end
