class CommentsController < ApplicationController
  before_action :autheticate_user
  def create
    picture = picture.find(params[:picture_id])
    @comment = picture.comments.build(comment_params)
    @comment.user_id = current_user.id
  if @comment.save
    flash[:success] ="コメントしました"
    redirect_back(fallback_location: root_path)
  else
    fladh[:success] = "コメントできませんでした"
    redirect_back(fallback_location: root_path)
 end
end
private
def comment_params
  params.require(:comment).permit(:content)
end
end
