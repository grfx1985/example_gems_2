class ArticlesController < ApplicationController

  expose :articles, ->{ decorated }
  expose :article, decorate: ->(article){ ArticleDecorator.new(article) }

  before_action :set_article, except: [:index]

  def decorated
    Article.all.map{ |article| ArticleDecorator.new(article) }
  end

  def new
  end

  def edit
  end

  def index
    policy_scope(Article)
  end

  def create
    article.user = current_user
    if article.save
      redirect_to article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    if article.update(article_params)
      redirect_to article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  def set_article
    authorize article
  end

  def article_params
    params.require(:article).permit(:title, :content, :published_at, :avatar, :moderated, :user_id)
  end
end
