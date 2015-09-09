class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "lochuynh", password: "lochuynh",
                                except: [:index, :show]

  def index
    @articles = Article.all
  end
  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # Article la 1 rails model extend ActiveRecord ==> se tu dong dinh mapping
    # db va dinh nghia nhung method save, update...
    @article = Article.new(article_params)

    if @article.save
      # redirect to active record that mean show this record
      # ==> Rails will redirect to article#show action
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  # Article also provide find method, request to controller --> return view
  def show
    @article = Article.find(params[:id])
  end

  private # all method under words 'private' is all private method
  def article_params
    params.require(:article).permit(:title, :text)
  end

end
