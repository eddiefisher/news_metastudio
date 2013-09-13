class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update]
  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  respond_to :html
  
  def index
    @articles = Article.index_query(params[:page])
  end

  def user_index
    @articles = current_user.articles.index_query(params[:page])
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.new
  end

  def edit
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
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    current_user.articles.destroy
    redirect_to articles_url
  end

  private
  
    def set_article
      @article = current_user.articles.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :user_id)
    end
end
