class Public::PostCommentsController < ApplicationController
  def create
    # 1. Postモデルで、params[:post_id]を使って投稿を取得
    post = Post.find(params[:post_id]) 
    
    # 2. post_idも一緒に渡してコメントオブジェクトを作成
    comment = current_member.post_comments.new(post_comment_params.merge(post_id: post.id))
    
    # 3. 保存に成功した場合のみメッセージを出すなど、分岐処理を入れるのが一般的
    comment.save 
    
    # 4. リファラがない場合のフォールバック先を指定
    redirect_to request.referer || post_path(post) 
  end

  def destroy
    # コメントを取得し、存在すれば削除
    comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    comment.destroy if comment
    
    # リファラがない場合のフォールバック先を指定
    redirect_to request.referer || post_path(params[:post_id])
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end