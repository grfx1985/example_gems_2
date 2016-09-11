class ArticlesController < ApplicationController

  expose :articles, ->{ decorated }
  expose :index_articles, ->{ indexed_articles }
  expose :show_a_article, -> { show_a_article }
  expose :article, decorate: ->(article){ ArticleDecorator.new(article) }, scope: ->{ users_articles }


  # after_action :verify_authorized, except: [:index, :show]


  def users_articles
    current_user.articles
  end

  def indexed_articles
    articles = Article.all
    articles.map{|r| authorize r}
  end

  def show_a_article
    article = ArticleDecorator.new(Article.find(params[:id]))
  end

  def decorated
    Article.all.map{ |article| ArticleDecorator.new(article) }
  end

  def show
    show_a_article
  end

  def index
    index_articles
  end

  def create
    authorize article
    if article.save
      redirect_to article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize article
    if article.update(article_params)
      redirect_to article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize article
    article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :published_at, :avatar, :moderated, :user_id)
  end
end
