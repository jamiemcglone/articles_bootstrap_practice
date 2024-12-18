class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order("created_at asc")
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to articles_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find_by(id: params[:id])
  end

  def update
    @article = Article.find_by(id: params[:id])
    if @article.update(article_params)
      redirect_to articles_path
      flash[:success] = "Article updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find_by(id: params[:id])
    if @article.destroy
      flash[:success] = "Article has been deleted"
    else
      flash[:errors] = "Article could not be deleted"
    end
    render :index
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
