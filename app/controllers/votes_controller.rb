class VotesController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @vote = Vote.new(vote_params)
    respond_to do |format|
      if count_voice?
        if @vote.save
          @article = Article.find(vote_params[:article_id])
          format.js {@status = 'success'}
        else
          format.js {@status = 'error'}
        end
      else
        format.js {@status = 'noaccess'}
      end
    end
  end
  
  private
    def count_voice?
      Vote.where(vote_params).count == 0 ? true : false
    end
    
    def vote_params
      params.require(:vote).permit(:article_id, :user_id)
    end
end
