class VotesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html
  
  def create
    @vote = Vote.new(vote_params)

    if count_voice?
      if @vote.save
        render js: 'alert("Tnk for you vote")'
      else
        render js: 'alert("error =(")'
      end
    else
      render js: 'alert("You can only vote once")'
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
