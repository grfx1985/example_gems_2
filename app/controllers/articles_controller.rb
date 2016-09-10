class ArticlesController < ApplicationController
  expose :articles, ->{ Article.all.map{ |article| ArticleDecorator.new(article) } }
  expose :article, decorate: ->(article){ ArticleDecorator.new(article) }

  def create
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

  def article_params
    params.require(:article).permit(:title, :content, :published_at, :avatar)
  end
end
