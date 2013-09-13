class ArticlesController < ApplicationController
  # before_action :set_article, only: [:show]
  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  respond_to :html
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.new
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    article = current_user.articles.find(params[:id])
    if article.update(article_params)
      redirect_to article, notice: 'Article was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    current_user.articles.destroy
    redirect_to articles_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :user_id)
    end
end
